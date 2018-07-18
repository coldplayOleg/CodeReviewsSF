trigger Task1a on Contact (after  insert, after  update) {

    if (Trigger.isInsert || Trigger.isUpdate) {
        List<Contact> contacts = (List<Contact>) Trigger.New;
        SearchManager searchCon = new SearchManager('test', 'Subject', 'Body email: ', contacts);
    }

}
