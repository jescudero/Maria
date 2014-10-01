//
//  NSManagedObject+Helper.h
//  Equinox
//
//  Created by Pedro Mancheno on 12/11/13.
//  Copyright (c) 2013 rga. All rights reserved.
//

@interface NSManagedObject (Helper)

+ (instancetype)createInContext:(NSManagedObjectContext *)context;

- (instancetype)inContext:(NSManagedObjectContext *)context;
- (instancetype)inMainContext;

+ (NSEntityDescription *)entityDescriptionInContext:(NSManagedObjectContext *)context;
+ (NSString *)entityName;

- (BOOL)destroy;
- (void)destroyInContext:(NSManagedObjectContext *)context;
- (BOOL)save;


/**
 * Find and return an existing object matching the info in a dictionary
 */
+ (instancetype)existingObjectWithDictionary:(NSDictionary *)dictionary
                            inContext:(NSManagedObjectContext *)context;

/**
 * Return an object based on the information in the dictionary.
 * If no object is found, return a newly created object in the specified context
 * Note: The created object is not saved to the persistent store
 * This methods assumes you have implemented the - primaryKey and - dictionaryKey
 * class methods in your subclass
 */
+ (instancetype)objectWithDictionary:(NSDictionary *)dictionary
                           inContext:(NSManagedObjectContext *)context;

+ (NSString *)primaryKey;
+ (NSString *)dictionaryKey;

@end
