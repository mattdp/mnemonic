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
  [x] implement notification model
  [x] figure out and implement how tied to Person
    [x] Person has_many events, so need person_id in events
  [x] implement birthday notifier generator
    [x] be able to figure out most recent event
    [x] if no birthday event in current year, create one
    [x] dismissed default to yes if start date + 1 month < today when generator run [never happens with the next_birthday stuff]
  [x] make a frontpage with notifications showing up there
    [x] set current date in model for testing; normally set to Date.today  
    [x] controller and simple view
    [x] link to admin panel
    [x] show content and notes for events that exist and aren't dismissed
    [x] implement start_date and fade_date
    [x] partialize; split into birthdays and wants/haves
v5 dismissal
  [] default false dismiss; set notes on event to text; add notes (text) on person 
  [] button to set dismiss to true
upload phase
  100 people
  10 wants/needs
  see how this works and if it proves at all useful in the next week, then come back with more updates next weekend


NEXT
add information about what people want and what people are looking for
store notes on people
backup data - where does it live? note in README; time machine should take care of it
implement email for fade_action
think about tags - seems a lot like SB - start with tags and families, with goal of select one for a list, and think about modifiers longer term
  people can call late in SF
  interested in activity X or Y
  location

bulk uploading
map relationships to each other
enough security to not just run it local
social network connections for harvesting
offshore worker connections for harvesting

MUCH BROADER
have a roster of personal to-dos and the date to do them (better asana or something?)