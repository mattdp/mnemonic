class TextParser

  def self.get_open
    file = File.open("/Users/matt/rails_projects/mnemonic/app/assets/fb_calendars-140814_pull/1.html")
    doc = Nokogiri::HTML(file)

    # get each hidden comment block and expose to nokogiri
    comment_containers = doc.xpath("//code[contains(@class,'hidden_elem')]").children
    parsable_comments = comment_containers.map{|cc| cc.content}
    parsable_comments.each do |pc|
      structured = Nokogiri::HTML(pc)
      #gets the word birthdays as many times as it's in this text
      structured.xpath("//div[contains(@class,'fbCalendarLabel fsm fwn fcg')]")
      #find the date from here
    end

    #Nokogiri::HTML(TextParser.get_open[0])

    #example of div with "birthdays" text, which is being found by the xpath

                                      #         value = "_51m- vTop hRght pas"
                                      #     })],
                                      # children = [
                                      #   #(Element:0x3ffc77471d38 {
                                      #     name = "div",
                                      #     attributes = [
                                      #       #(Attr:0x3ffc774709b0 {
                                      #         name = "class",
                                      #         value = "fbCalendarLabel fsm fwn fcg"
                                      #         })],
                                      #     children = [ #(Text "Birthdays")]
                                      #     })]

    #example of much higher level div containing the date

                      #     children = [
                      #   #(Element:0x3ffc75eca494 {
                      #     name = "div",
                      #     children = [
                      #       #(Element:0x3ffc75ece378 {
                      #         name = "h3",
                      #         attributes = [
                      #           #(Attr:0x3ffc75ed3418 {
                      #             name = "class",
                      #             value = "uiHeaderTitle"
                      #             })],
                      #         children = [
                      #           #(Text "Wednesday, January 1, 2014")]
                      #         })]
                      #     })]
                      # })]

        #example of where birthdays listed
            # children = [
            #   #(Element:0x3ffc774f4f1c {
            #     name = "a",
            #     attributes = [
            #       #(Attr:0x3ffc774f906c {
            #         name = "data-hover",
            #         value = "tooltip"
            #         }),
            #       #(Attr:0x3ffc774f9044 {
            #         name = "aria-label",
            #         value = "Michael Chao's birthday"
            #         }),
            #       #(Attr:0x3ffc774f901c {
            #         name = "class",
            #         value = "link"
            #         }),
            #       #(Attr:0x3ffc774f8fe0 {
            #         name = "href",
            #         value = "https://www.facebook.com/michaelchao"
            #         }),
            #       #(Attr:0x3ffc774f8fcc {
            #         name = "data-jsid",
            #         value = "anchor"
            #         })],



  end

end