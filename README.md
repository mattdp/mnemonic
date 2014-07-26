v1
store people's birthdays
  [x] get a postgres database running
  [x] institute Person - first name, last name, birthday, email
v2
  [x] look into admin page rails libraries to display them - be able to see people
v3 - SKIP since rails_admin is pretty awesome
  bulk editing - might be best to do all edits in a dumped csv, and reupload
  bulk adding - line without ID => new person with those attributes
v4 notifications - have things show frontpage on the day they are used
  [] implement notification model
  [] implement birthday notifier generator
  [] make a frontpage with notifications showing up there
    [] controller and simple view
    [] link to admin panel
    [] set current date in controller for testing; normally set to Date.today
    [] show content and notes for events that exist and aren't dismissed
    [] implement start_date and fade_date
    [] partialize; split into birthdays and wants/haves
v5 
notifications - have things show frontpage until dismissed (could have sessions, hit button and computes back to last time button hit)

NEXT
have a view of what people want and what people are looking for
have people's attributes decaying over time, ie want apartment lasts 2 months
store notes on people
be difficult to access for intruders - exposed rails app probably not the answer, running off local might be
backup data - where does it live? note in README; time machine should take care of it
implement email for fade_action

bulk uploading
map relationships to each other
social network connections for harvesting
offshore worker connections for harvesting

MUCH BROADER
have a roster of personal to-dos and the date to do them (better asana or something?)