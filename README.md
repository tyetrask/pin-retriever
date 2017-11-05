A tool to download images for Pinterest boards.

### Why
Pinterest's current web interface seems to display oddly when trying to use the browser's native zoom. This exists to easily collect all the images for a board or set of boards to use your image viewing tools of choice.

### To Use
Clone the project, retrieve your access token, and then:
```
./bin/pin_retriever -t YOUR_ACCESS_TOKEN -o /path/to/save
```

Within the specified output path, a directory will be created for each board. Within each directory will be images named by their `TODO`.

### To Run Tests
```
bundle exec test
```
