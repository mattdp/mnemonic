class TextParser

  require 'csv'
  require 'shellwords'

  def self.constant_hash
    return {
      first_name: 0,
      last_name: 1,
      email: 2
    }
  end

  #keep getting invalid byte sequence, maybe import this file, clean it, and export - eliminate commas, do normal CSV?
  #step 1: get a linkedin export, find/replace "," with ""
  #step 2: upload to google sheets and back, to fix a utf-8 encoding problem
  #step 3: f/r """ with " so don't have to get rid of quotes around every string
  def self.get_linkedin_profiles
    location = "/Users/matt/rails_projects/mnemonic/app/assets/li_contacts-141004_pull/connections_v2.csv"
    count = 0
    tag_id = Tag.find_by_name("LinkedIn connection").id
    verb_id = Verb.find_by_name("is my").id
    CSV.new(open(location)).each do |row|
      if count > 0 #skip title row
        person = TextParser.decide_if_update_or_new(row)
        [:first_name,:last_name,:email].each do |property|
          # nothing in the field, row has content, row isn't "None"
          if person.send(property).blank? and row[TextParser.constant_hash[property]].present? and row[TextParser.constant_hash[property]] != "None"
            person.update_attribute(property, row[TextParser.constant_hash[property]])
          end
        end
        Tagging.create_without_duplicates(person.id,verb_id,tag_id)
      end
      count += 1
    end
  end

  #input a row from the CSV
  #give back either a new Person or the existing Person 
  #sadly, don't have LI profile names to check on
  def self.decide_if_update_or_new(row)

    # repeated logic of if this returns something, return that, with last bit being a new person when tests aren't satisfied

    # if email address same
    p = Person.where("email = ?",row[TextParser.constant_hash[:email]]).take(1)
    return p[0] if p.present?

    # else if the firstname lastname are unique in the db, is this same lowercase without spaces
    p = Person.where("first_name = ? and last_name = ?",row[TextParser.constant_hash[:first_name]],row[TextParser.constant_hash[:last_name]]).take(1)
    return p[0] if p.present?

    # else if the full name is unique in the db, is this same lowercase without spaces
    p = Person.where("name = ?","#{row[TextParser.constant_hash[:first_name]]} #{row[TextParser.constant_hash[:last_name]]}").take(1)
    return p[0] if p.present?

    # if all tests fail and it's a new person
    return Person.create
  end

  def self.get_facebook_profiles
    file = File.open("/Users/matt/rails_projects/mnemonic/app/assets/fb_friendlist/140820.html")
    doc = Nokogiri::HTML(file)
    results = []

    person_links = doc.xpath("//div[contains(@class,'fsl fwb fcb')]")
    person_links.each do |pl|
      result = {}
      result[:name] = pl.text
      dirty_link = nil
      dirty_link = pl.children[0].attributes["href"].value if pl.children[0].attributes["href"]
      result[:link] = dirty_link[/\A[^?]*/] if dirty_link
      results << result if result[:link]
    end
    return results
  end

  #doesn't add the right FB friend tag
  def self.load_facebook_profiles_helper(human)

    tag_id = Tag.find_by_name_for_link("facebook_friend").id
    verb_id = Verb.find_by_name("is my")

    if Person.find_by_url_facebook(human[:link]).nil?
      newbie = Person.create({name: human[:name], url_facebook: human[:link]})
      Tagging.create({person_id: newbie.id, tag_id: tag_id, verb_id: verb_id})
    end

  end

  def self.load_facebook_profiles
    hash = TextParser.get_facebook_profiles

    hash.each do |human|
      TextParser.load_facebook_profiles_helper(human)
    end

  end

  def self.birthday_loader

    current_year = Date.today.year

    harvested = []
    [8].each do |month_number| #omit october, that was manual; august errors
      harvested.concat(TextParser.parse_calendar_page(month_number))
    end

    harvested.each do |human|
      if person = Person.find_by_url_facebook(human[:url_facebook])
        verbose_string = "#{human[:name]} located."
      else 
        person = Person.create({name: human[:name], url_facebook: human[:url_facebook]})
        person.save
        verbose_string = "#{human[:name]} created."
      end

      if person
        if person.birthday
          verbose_string += "\tBirthday already in place."
        else
          if person[:age]
            #2014 birthday (year of calendar pull) - age = old birthday
            year = (Date.new(2014,human[:month],human[:day]) - human[:age].years).year
          else
            year = 1900
          end
          birthdate = Date.new(year,human[:month],human[:day]).strftime('%Y-%m-%d')
          person.birthday = birthdate
          person.save
          verbose_string += "\tBirthday set to #{person.birthday}"
        end
      end

      puts verbose_string

    end

    return true

  end

# output format
# [{:name=>"Mark Trevail", :age=>27, :month=>10, :day=>2},
#  {:name=>"Steven Harley", :month=>10, :day=>4}, ...

  def self.parse_calendar_page(month_number)
    file = File.open("/Users/matt/rails_projects/mnemonic/app/assets/fb_calendars-140814_pull/#{month_number}.html")
    doc = Nokogiri::HTML(file)
    conclusions = []
    verbose = true

    hidden_code_blocks = doc.xpath("//code[@class = 'hidden_elem']")
    hidden_code_blocks.each do |code_block|
      payload = Nokogiri::HTML(code_block.children.text)
      birthday_links = payload.xpath("//a[contains(@aria-label,'birthday')]")
      birthday_links.each do |birthday_link|

        puts birthday_link if verbose

        person = {}

        person[:name] = birthday_link.children[0].attributes["alt"].value

        person[:url_facebook] = birthday_link.attributes["href"].value

        possible_age_string = birthday_link.attributes["aria-label"].value
        possible_age = possible_age_string.match(/.*\(([\d]*)/)
        person[:age] = possible_age[1].to_i if possible_age

        #pull up to div "class", value = "fbCalendarList" }), #(Attr:0x3fef46f0ee8c { name = "id", value = "fbCalendarDay1002"
        pointer = birthday_link
        n = 0
        while n < 11 do
          pointer = pointer.parent
          n += 1
        end
        date_text = pointer.children[0].children[0].children[0].children[0].children[0].text

        puts date_text if verbose

        if date_text != "Tomorrow" #special case in the day after did the crawl
          date = Date.parse(date_text) #failing in august
          person[:month] = date.month
          person[:day] = date.day

          conclusions << person
        end
      end
    end

    return conclusions
    # DEAD END - the data is hidden elsewhere and merged on page load, somehow even on my computer local copy
    # # .fbCalendarList #fbCalendarDay1002 <-- MMDD
    # # maybe iterate through the lists that have calendar days

    # #two_levels_above_date = doc.xpath("//div[@class = 'clearfix mvm mhl fbCalendarListContent']")[0]
    # pagelet_string = "//div[@class = 'clearfix mvm mhl fbCalendarListContent']/div[1]/div[contains(@id,'pagelet_calendar')]"
    # pagelets = doc.xpath("#{pagelet_string}")
    
    # #get to the links for birthdays, from there figure out how to get the dates

    # link_addendum = "/div"#[1]/ul[1]/li[1]/table[1]"
    # links = doc.xpath("#{pagelet_string}#{link_addendum}")


  end

end