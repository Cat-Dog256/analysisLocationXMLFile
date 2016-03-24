//
//  LCAnalysisLocationXML.m
//  analysisLocationXML
//
//  Created by 李策 on 16/3/23.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCAnalysisLocationXML.h"

@interface LCAnalysisLocationXML ()<NSXMLParserDelegate>
@property (nonatomic , strong) NSData *xmlData;
@property (nonatomic , strong) NSXMLParser *parserXml;
@property (nonatomic,  strong) NSArray *elementsToParse;
@property (nonatomic , strong) NSString *tagElementName;
@property (nonatomic , strong) NSString *tempElementName;

@property (nonatomic , strong) NSMutableArray *tagDictArray;
@property (nonatomic , copy) void(^analysisEndBlock)(NSArray *dictArray);
@property (nonatomic , strong) NSNumber *xmlType;
@end

@implementation LCAnalysisLocationXML
- (NSMutableArray *)tagDictArray{
    if (!_tagDictArray) {
        _tagDictArray = [NSMutableArray array];
    }
    return _tagDictArray;
}
- (void)startAnalyXMLWithFilePath:(NSString *)filePath andElementName:(NSString *)elementName andElements:(NSArray *)elementsArray andResult:(void (^)(NSArray *))resultBlcok{
    self.xmlData = [[NSData alloc]initWithContentsOfFile:filePath];
    self.parserXml = [[NSXMLParser alloc]initWithData:self.xmlData];
    self.elementsToParse = elementsArray;
    self.tagElementName = elementName;
    self.parserXml.delegate = self;
    [self setAnalysisEndBlock:^(NSArray *dictArray) {
        resultBlcok(dictArray);
    }];
    [self.parserXml parse];
}
- (void)startAnalyXMLWithFilePath:(NSString *)filePath andElementName:(NSString *)elementName andResult:(void (^)(NSArray *))resultBlcok{
    self.xmlData = [[NSData alloc]initWithContentsOfFile:filePath];
    self.parserXml = [[NSXMLParser alloc]initWithData:self.xmlData];
    self.tagElementName = elementName;
    self.parserXml.delegate = self;
    [self setAnalysisEndBlock:^(NSArray *dictArray) {
        resultBlcok(dictArray);
    }];
    [self.parserXml parse];
}
- (void)startAnalyXMLTypeThreeWithFilePath:(NSString *)filePath andElementName:(NSString *)elementName andResult:(void (^)(NSArray *))resultBlcok{
    self.xmlData = [[NSData alloc]initWithContentsOfFile:filePath];
    self.parserXml = [[NSXMLParser alloc]initWithData:self.xmlData];
    self.tagElementName = elementName;
    self.parserXml.delegate = self;
    self.xmlType = @3;
    [self setAnalysisEndBlock:^(NSArray *dictArray) {
        resultBlcok(dictArray);
    }];
    [self.parserXml parse];
}
#pragma mark**解析标签开始**
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict{
    self.tempElementName = elementName;
    if ([self.xmlType isEqualToNumber:@3]) {
        if ([elementName isEqualToString:
             self.tagElementName]) {
        [self.tagDictArray addObject:attributeDict];
        }
    }else{
        if ([elementName isEqualToString:
             self.tagElementName]) {
            NSString *identifier = [attributeDict objectForKey:@"id"];
            NSMutableDictionary *oneDic = [NSMutableDictionary dictionary];
            if (identifier.length != 0) {
                oneDic[@"id"] = identifier;
            }
            [self.tagDictArray addObject:oneDic];
        }

    }
}
#pragma mark**获取到标签对应的数据**
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    //NSString的方法，去掉字符串前后的空格
    NSString *resultString =  [string stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSMutableDictionary *dict = [self.tagDictArray lastObject];
    
    
    if (dict && resultString.length != 0) {
        if (self.elementsToParse) {
            for (int i = 0; i < self.elementsToParse.count; i++) {
                NSString *elemString = self.elementsToParse[i];
                if ([self.tempElementName isEqualToString:elemString]) {
                    dict[elemString] = resultString;
                }
            }
  
        }else{
            dict[@"item"] = resultString;
        }
    }
}
#pragma mark**解析标签结束**
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
}
#pragma mark**解析标签结束**
- (void)parserDidEndDocument:(NSXMLParser *)parser{
    
    self.analysisEndBlock(self.tagDictArray);
    
    self.elementsToParse = nil;
    self.tagElementName = nil;
    self.xmlData = nil;
    self.parserXml = nil;
    self.tagDictArray = nil;
}
@end
