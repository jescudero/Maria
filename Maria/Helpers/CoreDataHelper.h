//
//  EQCoreDataHelper.h
//  Equinox
//
//  Created by Pedro Mancheno on 12/11/13.
//  Copyright (c) 2013 rga. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "UIKitHelpers.h"

#define MAX_CORE_DATA_EXPRESSIONS 1000



@interface CoreDataHelper : NSObject <UIAlertViewDelegate>

#if TESTING
- (void)setSqliteStoreFilename:(NSString*)sqliteStoreFilename;
#endif

@property (nonatomic, strong, readonly) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator* persistentStoreCoordinator;

+ (CoreDataHelper *)sharedInstance;

- (void)setupCoreDataStack;
- (void)clearCoreDataStack;

- (BOOL)coreDataStackIsSetup;

- (NSURL*)databaseURL;
- (NSString*)databaseFileLocation;

- (void)refreshManagedObjectContext;
- (NSManagedObjectContext*)createBackgroundContext;

/**
 Convenience method for performing CoreData operations in a background thread.
 
 @param block   This block will get called in a private queue associated with the 'context' parameter it
 receives. All CoreData operations inside the block should use this particular context. Setting a non-nil
 value in *pError will abort the operation and execute the completion handler with an error status.
 Returning normally will execute the completion block with a successful status.
 
 @param completion  This block will be called on the main queue after executing the 'block' action.
 */

- (void)performInBackground:(void(^)(NSManagedObjectContext *context, NSError **pError))block
                 completion:(void(^)(BOOL success, NSError *error))completion;

/**
 Convenience method for performing CoreData operations in a background thread.
 
 These methods work like the 'performInBackground' method but they also save the context before calling
 the completion block.
 
 @param block   This block will get called in a private queue associated with the 'context' parameter it
 receives. All CoreData operations inside the block should use this particular context. Setting a non-nil
 value in *pError will abort the operation and execute the completion handler with an error status.
 Returning normally will cause the context to be saved and the completion block to be called.
 
 @param completion  This block will be called on the main queue after executing the 'block' action
 and saving the context.
 */

- (void)performAndSaveInBackground:(void(^)(NSManagedObjectContext *context, NSError **pError))block
                        completion:(void(^)(BOOL success, NSError *error))completion;


@end

