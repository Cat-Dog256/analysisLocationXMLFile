//
//  LCAnalysisLocationXML.h
//  analysisLocationXML
//
//  Created by 李策 on 16/3/23.
//  Copyright © 2016年 李策. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCAnalysisLocationXML : NSObject
/** 格式一
    <images>
        <id>2</id>
        <name>hottub3</name>
        <image>hottub-3.png</image>
        <artist>bluehost</artist>
    </images>
 **/
- (void)startAnalyXMLWithFilePath:(NSString *)filePath andElementName:(NSString *)elementName andElements:(NSArray *)elementsArray andResult:(void(^)(NSArray *dictArray))resultBlcok;
/** 格式二 返回dict格式为 {
                            id = "Asia/Bangkok";
                            item = Bangkok;
                        }

    <timezone id="Australia/Darwin">Darwin</timezone>
    **/
- (void)startAnalyXMLWithFilePath:(NSString *)filePath andElementName:(NSString *)elementName andResult:(void(^)(NSArray *dictArray))resultBlcok;
/**格式三 
 <city id="8636" name="北区" latitude="null"longitude="null"></city>**/
- (void)startAnalyXMLTypeThreeWithFilePath:(NSString *)filePath andElementName:(NSString *)elementName andResult:(void(^)(NSArray *dictArray))resultBlcok;

@end
