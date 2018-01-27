#import "NMSSHHostConfig.h"

@implementation NMSSHHostConfig

- (id)init {
    if ((self = [super init])) {
        [self setHostPatterns:@[ ]];
        [self setIdentityFiles:@[ ]];
    }
    return self;
}

- (NSArray<NSString *> *)arrayByRemovingDuplicateElementsFromArray:(NSArray<NSString *> *)array {
    NSMutableArray<NSString *> *deduped = [NSMutableArray<NSString *> array];
    for (NSString *string in array) {
        if (![deduped containsObject:string]) {
            [deduped addObject:string];
        }
    }
    return [deduped copy];
}

- (NSArray<NSString *> *)mergedArray:(NSArray<NSString *> *)firstArray withArray:(NSArray<NSString *> *)secondArray {
    NSArray<NSString *> *concatenated = [firstArray arrayByAddingObjectsFromArray:secondArray];
    return [self arrayByRemovingDuplicateElementsFromArray:concatenated];
}

- (void)mergeFrom:(NMSSHHostConfig *)other {
    [self setHostPatterns:[self mergedArray:self.hostPatterns
                                  withArray:other.hostPatterns]];
    if (!self.hostname) {
        [self setHostname:other.hostname];
    }
    if (!self.user) {
        [self setUser:other.user];
    }
    if (self.port == nil) {
        [self setPort:other.port];
    }
    [self setIdentityFiles:[self mergedArray:self.identityFiles
                                   withArray:other.identityFiles]];
}

@end

