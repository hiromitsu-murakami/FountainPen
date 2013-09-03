
#import <Foundation/Foundation.h>

#import <objc/runtime.h>


// ※ あまり使わない方が良さそう。
//   これを使う前に、そのメソッドと変数を別クラスに再設計できないかを検討してみる。
//
// そのスコープでのみ有効なインスタンス変数
// あるいは、そのインスタンスのみで有効なローカル変数
// 同じインスタンスでは同じ変数を参照するが、別のインスタンスからは参照しない。
// staticな変数は同じクラス内の別のインスタンスでも同じ変数を参照するが、この変数は参照しない。
//
// TODO: 宣言に型もあったほうがいいか？ 型をチェックする仕組みが欲しい。
// TODO: オブジェクト以外のプリミティブな型も使いたい。
// TODO: 廃棄用のキーの@"___fp_init_null"の値もしばらくretainされたままになってしまう。


// ローカルインスタンス変数の辞書
#define FPLIVs  ___fp_instance_dictionary


// ローカルインスタンス変数の宣言と初期化
// 辞書なのでnilを代入して初期化しようとするとクラッシュする。
#define FPInitLIVs(arg_name)                                \
NSString *arg_name = @(#arg_name);                          \
{                                                           \
    NSString *flag_##arg_name = @("___fp_flag_" #arg_name); \
    if (![FPLIVs[flag_##arg_name] boolValue]) {             \
        FPLIVs[flag_##arg_name] = @(YES);                   \
                                                            \
        ___fp_instance_init = arg_name;                     \
    }                                                       \
    else {                                                  \
        ___fp_instance_init = @"___fp_init_null";           \
    }                                                       \
}                                                           \
FPLIVs[___fp_instance_init]


// ローカルインスタンス変数の準備
// スコープごとに準備する必要がある。
#define FPReadyLocalInstanceVariables                                                               \
NSMutableDictionary *___fp_instance_dictionary = nil;                                               \
{                                                                                                   \
    static char obj_key = 0;                                                                        \
    ___fp_instance_dictionary = (id)objc_getAssociatedObject(self, &obj_key);                       \
    BOOL isNil         = !___fp_instance_dictionary;                                                \
    BOOL notDictionary = ![___fp_instance_dictionary isKindOfClass:[NSMutableDictionary class]];    \
    if (isNil || notDictionary) {                                                                   \
        ___fp_instance_dictionary = [NSMutableDictionary dictionary];                               \
        objc_setAssociatedObject(self,                                                              \
                                 &obj_key,                                                          \
                                 ___fp_instance_dictionary,                                         \
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);                                \
    }                                                                                               \
}                                                                                                   \
NSString *___fp_instance_init = @"___fp_init_null";

// 短縮
#define FPReadyLIVs  FPReadyLocalInstanceVariables


// サンプル
@interface FPLocalInstanceVariablesSample : NSObject

@property (nonatomic, strong) NSString *name;

- (void)sample;
- (void)sampleAlt;

@end
