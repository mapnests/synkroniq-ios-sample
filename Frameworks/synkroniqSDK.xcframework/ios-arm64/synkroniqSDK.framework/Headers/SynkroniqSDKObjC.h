#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SynkroniqSDKObjC : NSObject



+ (instancetype)shared;

- (void)initializeWithApiKey:(NSString *)apiKey 
                    platform:(NSString *)platform timeoutMs:(long)timeoutMs;

- (void)getServiceCategories:(NSString *)requestBody
                  completion:(void (^)(NSString * _Nullable json, BOOL success))completion;

- (void)getServiceCategoryById:(NSString *)categoryId
                   requestBody:(NSString *)requestBody
                    completion:(void (^)(NSString * _Nullable json, BOOL success))completion;

- (void)searchServiceCategories:(NSString *)requestBody
                     completion:(void (^)(NSString * _Nullable json, BOOL success))completion;

- (void)getTickets:(NSString *)requestBody
        completion:(void (^)(NSString * _Nullable json, BOOL success))completion;

- (void)createTicket:(NSString *)requestBody
          completion:(void (^)(NSString * _Nullable json, BOOL success))completion;

- (void)getTicketArticles:(NSString *)requestBody
               completion:(void (^)(NSString * _Nullable json, BOOL success))completion;

- (void)addTicketArticle:(NSString *)requestBody
              completion:(void (^)(NSString * _Nullable json, BOOL success))completion;

- (void)getTicketStates:(NSString *)requestBody
             completion:(void (^)(NSString * _Nullable json, BOOL success))completion;


@end

NS_ASSUME_NONNULL_END
