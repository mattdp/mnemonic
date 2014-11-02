START USING DAY TO DAY

[x] when save person and name field is blank, automatically update name fields if first last in there, or if name easily splittable
  if first and last name blank, and name and name splittable, put in first and last name
  if name blank, and first name, put in first + space last name

[] taggings new flow - do with search boxes, not with checkboxes. goal is to learn how to use these, since they make other flows feasible. could half-ass with hidden javascript, but i'd love to duplicate what rails_admin has
  https://shellycloud.com/blog/2013/10/adding-search-and-autocomplete-to-a-rails-app-with-elasticsearch

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