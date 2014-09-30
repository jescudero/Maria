//
//  Friend.h
//  CIOForum
//
//  Created by Juan Escudero on 7/14/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Usuario : NSManagedObject

+ (Usuario *)currentUser;
+ (BOOL)loggedIn;

@property (nonatomic, strong) NSString *idUsuario;
@property (nonatomic, strong) NSString *nombre;
@property (nonatomic, strong) NSString *apellido;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *password;

-(void)isLoggedIn:(BOOL)loggedIn;
-(void)saveDataToDefault;

@end
