A tool to download images for Pinterest boards.

### Why
Pinterest's current web interface seems to display oddly when trying to use the browser's native zoom. This exists to easily collect all the images for a board or set of boards to use your image viewing tools of choice.

### To Use
1. Create a Pinterest [access token](https://developers.pinterest.com/tools/access_token/)
1. Clone the repository
1. `$ cd pin_retriever`
1. `$ ./bin/pin_retriever -t YOUR_ACCESS_TOKEN -o /path/to/save`

Within the specified output path, a directory will be created for each board `name`. Within each directory will be images named by their pin `id`.

(Only public boards can be retrieved via API)

### To Test
```
bundle exec test
```

### To Do
- [ ] Increase error handling coverage and clarity
- [ ] Cursor/caching in case user has many boards
- [ ] Test coverage
- [ ] Finish Pinterest API Client or consider using an existing one
