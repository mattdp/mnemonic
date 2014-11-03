START USING DAY TO DAY

[] taggings new flow - do with search boxes, not with checkboxes. goal is to learn how to use these, since they make other flows feasible. could half-ass with hidden javascript, but i'd love to duplicate what rails_admin has
  https://shellycloud.com/blog/2013/10/adding-search-and-autocomplete-to-a-rails-app-with-elasticsearch - need elasticsearch running
  https://github.com/crowdint/rails3-jquery-autocomplete - less clear example, don't need a full search engine through
  http://flaviodesousa.com/blog/autocomplete-over-associations-in-rails-4/ - useful secondary example
  http://graffzon.tumblr.com/post/31730804641/lightweight-handmade-solution-for-jquery-autocomplete - useful example

[] main issue - not using due to
  [] spin up - it's not always just there
    run on a small computer at home all the time, connect to it from laptop?
  [] annoying to add information
    maybe - trying this in a text file
      batch file - one line of each instruction, execute afterwards
      ability to add multiple tags to a person easily, with suggested verb

[] figure out linkedin importing
  [] reader for the import - print line by line, get same number of lines
  [] how make update vs new choice? 
    if email address same
    else if linkedin profile url same, ideally domainatrixed to standardize
    else if the firstname lastname are unique in the db, is this same lowercase without spaces
    else if the full name is unique in the db, is this same lowercase without spaces
  [] figure out how generally merging two identities 
  [] autoadd a linkedin connected tag and their linkedin profile address
  [] figure out how highlighting potential duplicates
  [] test on a small fraction of the data set
  [] run on whole thing
  [] name splitter for the recent additions
---

backup data - where does it live? note in README; time machine should take care of it for now
implement email for fade_action

map relationships to each other
enough security to not just run it local - should this be a server only accessible from certain machines or something?
social network connections for harvesting (FB, LI, email?)
offshore worker connections for harvesting

MUCH BROADER
have a roster of personal to-dos and the date to do them (better asana or something?)
  ^ this feels like a different project