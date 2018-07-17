trigger Task1a on Contact (before insert, before update) {

    if (Trigger.isInsert || Trigger.isUpdate) {
        SearchManager searchCon = new SearchManager('test', 'Subject', 'Body email: ', Trigger.New);
        searchCon.searchContact();
    }

}
