
#Sweat Buddies
____________

Project 2 for GA WDI6 Melbourne

Written in Ruby using Sinatra framework and Bootstrap CSS. 

###The Pitch
Sweat Buddies is an app that helps a user find other people to exercise with, based on common interest areas. Users can also post an event or view community event listings.

[Sweat Buddies on Heroku](https://sweatbuddies.herokuapp.com)

___________________________________________________________________________________

####Key Points of this project:
- Users can log in and out and passwords are encryted using bcyrpt
- Users can create and edit their profile
- Users and interests are linked using a many to many Active Record association, allowing access to users with common interests.
- Users can create events and each event belongs to an interest area.
- There are custom alerts when users make an error with sign in or profile information, using some of the functionality of the Sinatra-Flash gem, with code written to work with Bootstrap alerts. There are Active Record validations in place to avoid blank data fields and prevent users signing up more than once with the same email address.

___________________________________________________________________________________

####Possible future directions for this project:
- Better CSS Styling! 
- A messaging system for users rather than the dubious mail-to links to user email addresses that it has at the moment.
- A search function on more than just interests - like location. At this point, the app is best suited to small local community use only.
- Capacity for users to join events.





