//
//  ViewController.m
//  analysisLocationXML
//
//  Created by 李策 on 16/3/23.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "ViewController.h"
#import "LCAnalysisLocationXML.h"
@interface ViewController ()<NSXMLParserDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    LCAnalysisLocationXML *analysisXML = [[LCAnalysisLocationXML alloc]init];
    NSString *path1 = [[NSBundle mainBundle]pathForResource:@"images" ofType:@"xml"];
    [analysisXML startAnalyXMLWithFilePath:path1 andElementName:@"images" andElements:@[@"name",@"image",@"artist"] andResult:^(NSArray *dictArray) {
        NSLog(@"XML%@",dictArray);
    }];
//
    NSString *paht2 = [[NSBundle mainBundle]pathForResource:@"timezones" ofType:@"xml"];
    [analysisXML startAnalyXMLWithFilePath:paht2 andElementName:@"timezone" andResult:^(NSArray *dictArray) {
        NSLog(@"XML%@",dictArray);
    }];
    NSString *paht3 = [[NSBundle mainBundle]pathForResource:@"country" ofType:@"xml"];
    [analysisXML startAnalyXMLWithFilePath:paht3 andElementName:@"item" andResult:^(NSArray *dictArray) {
        NSLog(@"XML%@",dictArray);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
