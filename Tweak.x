// Stonks - Changes all "Stocks" text to "Stonks"
// By Skitty

static BOOL enabled = YES;

NSString *stocksToStonks(NSString *origString) {
	NSString *newString = [origString stringByReplacingOccurrencesOfString:@"Stocks" withString:@"Stonks"];
	newString = [newString stringByReplacingOccurrencesOfString:@"stocks" withString:@"stonks"];
	newString = [newString stringByReplacingOccurrencesOfString:@"STOCKS" withString:@"STONKS"];
	newString = [newString stringByReplacingOccurrencesOfString:@"stocks" withString:@"stonks" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [newString length])];
	return newString;
}
NSAttributedString *attributedStocksToStonks(NSAttributedString *origString) {
	NSMutableAttributedString *newString = [origString mutableCopy];
	while ([newString.mutableString containsString:@"Stocks"]) {
        NSRange range = [newString.mutableString rangeOfString:@"Stocks"];
		NSMutableAttributedString *replaceString = [[NSMutableAttributedString alloc] initWithString:@"Stonks"];
		[newString enumerateAttributesInRange:range options:0 usingBlock:^(NSDictionary<NSAttributedStringKey, id> *attrs, NSRange range, BOOL *stop) {
			[replaceString addAttributes:attrs range:NSMakeRange(0, replaceString.length)];
		}];
        [newString replaceCharactersInRange:range withAttributedString:replaceString];
    }
	return [newString copy];
}

// Global text views
%hook UILabel
- (void)setText:(NSString *)text {
	if (enabled) {
		text = stocksToStonks(text);
	}
	%orig(text);
}
- (void)setAttributedText:(NSAttributedString *)attributedText {
	if (enabled) {
		attributedText = attributedStocksToStonks(attributedText);
	}
	%orig(attributedText);
}
%end

%hook UITextView
- (void)setText:(NSString *)text {
	if (enabled) {
		text = stocksToStonks(text);
	}
	%orig(text);
}
- (void)setAttributedText:(NSAttributedString *)attributedText {
	if (enabled) {
		attributedText = attributedStocksToStonks(attributedText);
	}
	%orig(attributedText);
}
%end

// App names
%hook SBApplication
- (void)setDisplayName:(id)name {
	if (enabled){
		name = stocksToStonks(name);
	}
	%orig(name);
}
- (id)displayName {
	return stocksToStonks(%orig);
}
%end

// Folder names
%hook SBFolder
- (void)setDisplayName:(id)name {
	if (enabled){
		name = stocksToStonks(name);
	}
	%orig(name);
}
- (id)displayName {
	return stocksToStonks(%orig);
}
%end
