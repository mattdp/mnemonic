class TextParser

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

end