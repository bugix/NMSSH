#import "NMSSHHostConfig.h"

@implementation NMSSHHostConfig

- (instancetype)init {
    if ((self = [super init])) {
        self.hostPatterns = @[ ];
        self.identityFiles = @[ ];
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
    self.hostPatterns = [self mergedArray:self.hostPatterns
                                  withArray:other.hostPatterns];
    if (!self.hostname) {
        self.hostname = other.hostname;
    }
    if (!self.user) {
        self.user = other.user;
    }
    if (self.port == nil) {
        self.port = other.port;
    }
    self.identityFiles = [self mergedArray:self.identityFiles
                                   withArray:other.identityFiles];
}

@end

