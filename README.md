# Fetch Recipes

### Steps to Run the App
Pull the repo and build on xcode simulator. Minimum deployment version is 16.6.

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?
I focused mostly on performance, functionality, and test coverage while leaving the UI as barebones as possible.
I chose this because UI generally just takes me longer to get done. I also wanted to demonstrate a version that
I would be comfortable with shipping.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?
I spent the full 5 hours. My plan was to see how much I could do in 5 hours and no more. 
I allocated at least half of that time for testing and clean up. 

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?
I decided to implement image caching over importing a third party library since it involved simply adding 
a searchable dictionary to AsyncImage.

### Weakest Part of the Project: What do you think is the weakest part of your project?
The weakest part is probably the pull to refresh feature. It's not immediately apparent that the feature exists
and it also does not have a nice smooth feel to it. If I had more time, I would focus on this next.

### External Code and Dependencies: Did you use any external code, libraries, or dependencies?
None

