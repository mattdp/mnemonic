START USING DAY TO DAY

[] usable admin pages
  http://localhost:3000/admin/tagging/new
    tags have info in name field
    [x] verb - could change description to name
    [] person - need a way that when people save, their full name goes into name field
      could just be on create it gets combined, i like that a lot
[] person page - sentence of tagging verb and of content (date tag in)
[] person page accessable from eyeball on the admin page

v6 upload phase
  SPEC
    100 people
    10 wants/needs
    see how this works and if it proves at all useful in the next week, then come back with more updates next weekend
    POSSIBLE SOLUTIONS
      https://github.com/arsduo/koala
  STEPS
    [x] harvest the fb calendar data
    [] have crawler able to get birthdays, ages (2014 pull), profile links from a file
    [] from all files
    [] allow batch program to create new users, checking if that fb_id exists already
    [] pull in all fb friends and their birthdays

v? tags
  [] for a given tag 
    [] have a page on the site
    [] show all people tagged with it and their emails
    [] have a copyable list at the top for all the emails with commas

[] launch in 1 click - rails s, postgres, firefox. 

NEXT
add information about what people want and what people are looking for
store notes on people
backup data - where does it live? note in README; time machine should take care of it
implement email for fade_action

remove tags
map relationships to each other
enough security to not just run it local - should this be a server only accessible from certain machines or something?
social network connections for harvesting (FB, LI, email?)
offshore worker connections for harvesting

MUCH BROADER
have a roster of personal to-dos and the date to do them (better asana or something?)