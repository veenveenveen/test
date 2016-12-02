//
//  Note+CoreDataProperties.m
//  test
//
//  Created by 黄启明 on 2016/12/1.
//  Copyright © 2016年 huatengIOT. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Note+CoreDataProperties.h"

@implementation Note (CoreDataProperties)

+ (NSFetchRequest<Note *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Note"];
}

@dynamic title;
@dynamic details;
@dynamic creatTime;
@dynamic sectionName;
@dynamic intervalFlag;

@end
