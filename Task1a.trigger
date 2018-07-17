trigger Task1a on Contact (after  insert, after  update) {

    if (Trigger.isInsert || Trigger.isUpdate) {
        SearchManager searchCon = new SearchManager('test', 'Subject', 'Body email: ', Trigger.New);
        searchCon.searchContact();
    }

}
