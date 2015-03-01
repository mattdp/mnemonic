https://trello.com/b/Ek773dQs/mnemonic
--
ILP method, from kei, about how they do clinic self-examination

how do you expect to feel while doing this task?
what good at, expected?
what bad at, expected?
how prep for things bad at?

DO THE TASK

<essay for self-assessment>
  how did you feel?
  what hurdles did you encounter?
  how did you deal with them?
  how could you have dealt with them better?
  what's one thing you learned?
--

survey - one time doing one session of question answers
question - one question, survey has_many of them
answer - answer, question has_one of them

make survey each time, questions persistant
answer has_one survey has_one question and then answer attributes

survey
  timestamps
  notes
  *have a basic method to print the questions and answers from a survey

question
  text of question (string)
  answer_type text|integer
  ordering (1 first, 10 last, tie arbitrary)

answer
  content_text (text)
  content_integer (integer)
  answer_type [:one_to_ten, :freeform]
  *have a get_answer method that does any necessary selecting/casting

--

interesting brainstorm for what to try with game i created that fizzled out
  instead of playing to make the rules
  rate what productivity/activity is like
    have hundreds of possible things to do, match the what to do with the productivity or difficulty rating for what looking to do
    have a wheel for selection to make it feel more fun
    be able to see what effect it had on mood - show how felt before and felt after

thinking of life as a game, when i play a game that'll be around for a while i focus on the metaskills - how do you increase your ability to increase your ability. thinking over the partner's diverse lives at HAX, being a renaissance man really appealing, being able to attack virtually any problem and find answers. thinking about what some of those metaskills are, big one 
  is being able for form relationship across class and culture - find and care about someone's story and create a spark
  discipline - apply oneself to a task consistantly
  outlook - how do you take the right spin on things
  community - how do you get people involved in and excited about what you care about