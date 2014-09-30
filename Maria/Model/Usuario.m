//
//  Friend.m
//  CIOForum
//
//  Created by Juan Escudero on 7/14/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import "Usuario.h"

@implementation Usuario

@dynamic idUsuario;
@dynamic nombre;
@dynamic apellido;
@dynamic email;
@dynamic nickName;
@dynamic password;

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        //decode properties, other class vars
        self.idUsuario = [decoder decodeObjectForKey:@"idUsuario"];
        self.nombre = [decoder decodeObjectForKey:@"nombre"];
        self.apellido = [decoder decodeObjectForKey:@"apellido"];
        self.email = [decoder decodeObjectForKey:@"email"];
        self.nickName = [decoder decodeObjectForKey:@"nickName"];
        self.password = [decoder decodeObjectForKey:@"password"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.idUsuario forKey:@"idUsuario"];
    [encoder encodeObject:self.nombre forKey:@"nombre"];
    [encoder encodeObject:self.apellido forKey:@"apellido"];
    [encoder encodeObject:self.email forKey:@"email"];
    [encoder encodeObject:self.nickName forKey:@"nickName"];
    [encoder encodeObject:self.password forKey:@"password"];

}


-(void)saveDataToDefault
{
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:self];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:encodedObject forKey:@"currentUser"];
    [defaults synchronize];
}


- (Usuario *)loadCustomObjectWithKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:key];
    Usuario *object = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    return object;
}


+ (Usuario *)currentUser{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSData *encodedObject = [defaults objectForKey:@"currentUser"];
    Usuario *user = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    return user;
    
}

+ (BOOL)loggedIn{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults boolForKey:@"loggedin"];
}

-(void)isLoggedIn:(BOOL)loggedIn{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:loggedIn forKey:@"loggedin"];
    [defaults synchronize];
}

@end
