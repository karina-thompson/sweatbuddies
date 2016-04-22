
#Sweat Buddies

Project 2 for GA WDI6 Melbourne

Written in Ruby using Sinatra framework and Bootstrap CSS styling. 

###The Pitch
Sweat Buddies is an app that helps a user find other people to exercise with, based on common interest areas. Users can also post an event or view community event listings.

[Sweat Buddies on Heroku](https://sweatbuddies.herokuapp.com)

[My Github repository for this app](https://github.com/nakarielle/sweatbuddies)

This was a real learning experience in building my first full-stack web app. The approach I took was perhaps not the best one in hindsight, next time I would try and plan more comprehensively before starting. A major challenge in planning was not knowing how long things would take and therefore how much I could feasibly get done in one week. I did make use of Trello to keep track of tasks, which I found helpful and I tried to develop both the backend and front end for each part of the site before moving on (although this didn't quite happen towards the end - the front end definitely needs some more work!)

####Key Points of this project:
- Users can log in and out and passwords are encryted using bcyrpt
- Users can create and edit their profile
- Users and interests are linked using a many to many Active Record association, allowing access to users with common interests.
- Users can create events and each event belongs to an interest area.
- There are custom alerts when users make an error with sign in or profile information, using some of the functionality of the Sinatra-Flash gem, with code written to work with Bootstrap alerts.

####There is a lot more I would add to this app given more time (and in some cases, more advanced skills), including:
- Better CSS Styling! 
- A messaging system for users rather than the dubious mail-to links to user email addresses that it has at the moment!
- The ability for a user to delete events that they created (This is a work in progress at the moment...)
- The ability to search on more than just interests - like location. At this point, the app is best suited to small local community use only.
- Perhaps eventually this could expand to allow users to join events.





