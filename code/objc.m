BOOL result = [myData writeToFile:@"/tmp/log.txt" atomically:NO];

[NSString stringWithFormat: @"Status: %@", (statusBool ? @"Approved" : @"Rejected")]
