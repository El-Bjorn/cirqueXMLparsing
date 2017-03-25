//
//  SMTViewController.m
//  cirqueXMLparsing
//
//  Created by Bjorn Chambless on 5/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SMTViewController.h"
#import "DDXML.h"
#import "DDXMLElementAdditions.h"

// Private methods
@interface SMTViewController ()
-(void)parseXML:(NSString*)source;
@end


@implementation SMTViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //NSError *error;
    
    //DDXMLDocument *xmldoc;
    //NSFileManager *fm = [NSFileManager defaultManager];
    NSString *xmlFilePath = [[NSBundle mainBundle] pathForResource:@"offers-feed" ofType:@"xml"];
    NSLog(@"xml file path= %@",xmlFilePath);
    
    NSString *xmlFileContents = [NSString stringWithContentsOfFile:xmlFilePath 
                                                          encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"xml file contents= %@",xmlFileContents);
    
    //NSError *error;
    //NSString *content = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bookstore" ofType:@"xml"] encoding:NSUTF8StringEncoding error:&error;];
    
    //[self parseXML:xmlFileContents];   
    NSError *error = nil;
    DDXMLDocument *theDocument = [[DDXMLDocument alloc] initWithXMLString:xmlFileContents options:0 error:&error ];
    
    NSArray *offerNodes = [theDocument nodesForXPath:@"//offer" error:&error];
    
    for (DDXMLElement *offer in offerNodes) {
        NSMutableDictionary *offerDict = [NSMutableDictionary dictionaryWithDictionary:[offer childrenAsDictionary]];
        //NSLog(@"offerDict= %@",offerDict);
        DDXMLElement *bookingElement = [offer elementForName:@"booking"];
        DDXMLElement *phoneElement = [bookingElement elementForName:@"phonenumber"];
        [offerDict setObject:[phoneElement stringValue] forKey:@"phonenumber"];
        
        DDXMLElement *linksElement = [bookingElement elementForName:@"links"];
        DDXMLNode *mobileLinkNode = [linksElement childAtIndex:1];
        DDXMLNode *mobileURLNode = [mobileLinkNode childAtIndex:0];
        DDXMLNode *mobileLabelNode = [mobileLinkNode childAtIndex:1];
        
        //NSLog(@"mobile URL= %@",[mobileURLNode stringValue]);
        [offerDict setObject:[mobileURLNode stringValue] forKey:@"mobileURL"];
        [offerDict setObject:[mobileLabelNode stringValue] forKey:@"mobileLabel"];
        
        NSLog(@"offerDict= %@",offerDict);
        
        
        
        
        
        NSLog(@"================");
        //fprintf(stderr, "node kind= %d\n",[offer kind]);
        //NSLog(@"node name= %@",[offer name]);
        //fprintf(stderr, "node index= %d\n",[offer index]);
        //fprintf(stderr, "node level= %d\n",[offer level]);
        //fprintf(stderr, "number of children= %d\n",[offer childCount]);
        /*NSArray *children = [offer children];
        for (DDXMLNode *child in children){
            NSLog(@"child= %@",child);
        } */
        //DDXMLElement *booking = [offer elementForName:@"booking"];
        //fprintf(stderr, "booking has %d children\n",[booking childCount]);
        //DDXMLElement *linkSection = [booking elementForName:@"links"];
        //NSLog(@"links child= %@",linkSection);
        //fprintf(stderr, "links has %d children\n",[linkSection childCount]);
        /*NSArray *links = [linkSection children];
        for (DDXMLNode *link in links){
            NSLog(@"link child= %@",link);
            fprintf(stderr, "link child has %d children\n",[link childCount]);
            NSArray *c = [link children];
            for (DDXMLNode *l in c) {
                NSLog(@"l = %@",l);
            }
        } */
        //NSLog(@"booking child= %@",[offer elementForName:@"booking"]);
        //NSLog(@"offer= %@",offer);
    }
    
    /*NSArray *results = [theDocument nodesForXPath:@"/bookstore/book[price>35]" error:&error];
    
    for (DDXMLElement *book in results) {
        
        NSLog(@"-----------");
        
        NSString *category = [[book attributeForName:@"category"] stringValue];
        
        NSLog(@"category:%@",category);
        
        for (int i = 0; i < [book childCount]; i++) {
            DDXMLNode *node = [book childAtIndex:i];
            NSString *name = [node name];
            NSString *value = [node stringValue];
            NSLog(@"%@:%@",name,value);
        }
    } */
    /*xmldoc = [[DDXMLDocument alloc] initWithXMLString:xmlFileContents 
                                              options:0 error:&error];
    if (error) {
        NSLog(@"error=%@",[error localizedDescription]);
    }
    
    NSLog(@"xmldoc=%@",xmldoc);
    
    NSArray *elements = [xmldoc nodesForXPath:@"//offer" error:&error];
    
    NSLog(@"elements= %@",elements);
    
    for (DDXMLElement *element in elements){
        NSLog(@"element= %@",element);
    } */
    
    
    
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)parseXML:(NSString*)source {
    
    NSError *error = nil;
    DDXMLDocument *theDocument = [[DDXMLDocument alloc] initWithXMLString:source options:0 error:&error ];
    
    NSArray *results = [theDocument nodesForXPath:@"/bookstore/book[price>35]" error:&error];
    
    for (DDXMLElement *book in results) {
        
        NSLog(@"-----------");
        
        NSString *category = [[book attributeForName:@"category"] stringValue];
        
        NSLog(@"category:%@",category);
        
        for (int i = 0; i < [book childCount]; i++) {
            DDXMLNode *node = [book childAtIndex:i];
            NSString *name = [node name];
            NSString *value = [node stringValue];
            NSLog(@"%@:%@",name,value);
        }
    }
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
