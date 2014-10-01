//
//  NSManagedObject+Helper.m
//  Equinox
//
//  Created by Pedro Mancheno on 12/11/13.
//  Copyright (c) 2013 rga. All rights reserved.
//

#import "CoreDataHelper.h"
#import "NSManagedObject+Finders.h"

@implementation NSManagedObject (Helper)

+ (instancetype)createInContext:(NSManagedObjectContext *)context
{
    return [NSEntityDescription insertNewObjectForEntityForName:[self entityName] inManagedObjectContext:context];
}

- (instancetype)inContext:(NSManagedObjectContext *)context
{
    if (context == self.managedObjectContext)
        return self;
    
    return [context objectWithID:self.objectID];
}

- (instancetype)inMainContext
{
    return [self inContext:[CoreDataHelper sharedInstance].managedObjectContext];
}

+ (NSEntityDescription *)entityDescriptionInContext:(NSManagedObjectContext *)context
{
    return [NSEntityDescription entityForName:[self entityName] inManagedObjectContext:context];
}

+ (NSString *)entityName
{
    return NSStringFromClass(self);
}

- (BOOL)destroy
{
    [[CoreDataHelper sharedInstance].managedObjectContext deleteObject:self];
    if ([self save]) {
        return YES;
    }
    NSLog(@"Error deleting object: %@", self);
    return NO;
}

- (void)destroyInContext:(NSManagedObjectContext *)context
{
    [context deleteObject:self];
}

- (BOOL)save
{
    return [[CoreDataHelper sharedInstance].managedObjectContext save:0];
}

+ (instancetype)existingObjectWithDictionary:(NSDictionary *)dictionary
                                   inContext:(NSManagedObjectContext *)context
{
    id lookupObject = [self convertedPrimaryKeyValue:dictionary[[self dictionaryKey]]];

    
    NSArray* objects = [self findAllWhereField:[self primaryKey]
                                      equals:lookupObject
                                   inContext:context withError:nil];
    
    return [objects count] > 0 ? objects[0] : nil;
}

+ (instancetype)objectWithDictionary:(NSDictionary *)dictionary
                           inContext:(NSManagedObjectContext *)context
{
    NSManagedObject *obj = [self existingObjectWithDictionary:dictionary
                                                    inContext:context];
    if (!obj) {
        obj = [self createInContext:context];
    }
    return obj;
}

+ (NSString *)primaryKey
{
    // implement in subclass
    return nil;
}

+ (NSString *)dictionaryKey
{
    // implement in subclass
    return nil;
}

+ (id)convertedPrimaryKeyValue:(id)primaryKey
{
    if ([primaryKey isKindOfClass:[NSString class]]) {
        return @([primaryKey integerValue]);
    }
	
	return primaryKey;
}

@end