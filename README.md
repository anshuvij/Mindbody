# Mindbody

Requirements handled :

Countries Screen
1. Load and display the list of countries from the API -
https://connect.mindbodyonline.com/rest/worldregions/country
a. Loading - a loading spinner should be used while the API request is occuring
b. Error - show some error text (exception name is fine) with a retry button
c. Success - display a list of country names
d. Config Changes should not re-fetch the data
e. A pull-to-refresh should trigger a new API request and update the data
f. Optional - display flags next to the country names -
https://github.com/hjnilsson/country-flags/tree/master/png250px

Country Details Screen
1. Load from the API and display a list of provinces from the previously selected country -
https://connect.mindbodyonline.com/rest/worldregions/country/{ID}/province
a. Loading - a loading spinner should be used while the API request is occurring
b. Error - show some error text (exception name is fine) with a retry button
c. Success - display a list of province names
d. Empty - show a message when there is no provinces for a country
e. Optional - Display a map partially above the list, zoomed to the country. When tapping a
province, zoom to the province region on the map
