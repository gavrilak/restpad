/*
    Kb - keyboard
    Tf - TextField
 */


//#import <CoreLocation/CoreLocation.h>


#define ALog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

#define EmptyString             @""

//#define HTTP @"http://192.168.1.101:8080/"
#define HTTP @"http://192.168.1.101:8080"


#define kMenuCatsCellReuseId        @"MenuCatsCell"
#define kMenuCatCellReuseId         @"MenuCatCell"
#define kStaffCellReuseId           @"StaffCell"
#define kOrdersCellReuseId          @"OrdersCell"
#define kWaiterNoticesCellReuseId   @"WaiterNoticesCell"
#define kAdminNoticesCellReuseId    @"AdminNoticesCell"
#define kDishCellReuseId            @"DishCell"
#define kHallsCellReuseId           @"HallsCell"


#define ERROR_MESSAGE @"Отсутствует связь с сервером!"
#define HALLS1 @"Терраса"
#define HALLS2 @"Зал"
#define HALLS3 @"Второй этаж"


#define DESSERTS @"Desserts"
#define SALADS @"Salads"
#define SOUPS @"Soups"
#define ALCOHOL @"Alcohol"
#define DRINKS @"Drinks"


#pragma mark - Enums

typedef enum {
    sales_rankings,
    consumption_of_food,
    revenue,
    list_of_staff,
    salary,
    customer_rating,
    movement_of_customers,
    infograph
} StatisticsType;

typedef enum {
    CURRENTSWITCH,
    ALLSWITCH
} SwitchType;

typedef enum {
    FIRSTROOM,
    SECONDROOM,
    THIRDROOM,
    FOURTHROOM
} RoomType;

typedef enum {
    CATEGORYTABLE,
    SUBCATEGORYTABLE,
    NOTICETABLE,
    ORDERSLIST,
    EMPLOYEER,
    WAREWHOUSE,
    HALLS,
    SWIPE
} TableType;

typedef enum {
    CURRENTTYPE = 0,
    ALLTYPE,
} OrdersHistoryType;

#pragma mark -ImageFor enum
typedef enum {
    /*
     * General
     */
    ImageForControllerViewBg,
    ImageForVirtTableFrame,
    ImageForVirtTableBtn,
    // Detail view
    ImageForDetailPicDecor,
    
    /*
     * TabBar
     */
    ImageForTabBarBg,
    ImageForTabBarItemTables,
    ImageForTabBarItemMenu,
    ImageForTabBarItemOrders,
    ImageForTabBarItemNotices,
    
    /*
     * NavBar
     */
    ImageForNavBarBg,
    ImageForNavBarBtnBack,
    
    /*
     * Auth
     */
    ImageForAuthBg,
    ImageForAuthTfBg,
    ImageForAuthBtnEnter,
    
    /*
     * Halls
     */
    ImageForHallsBtnLogout,
    ImageForHallsBtnTable,
    ImageForHallsBtnTableBusy,
    ImageForHallsBtnTableWait,
    ImageForHallsDoor,
    ImageForHallsBar,
    ImageForHallsBtnEdit,
    ImageForHallsBtnMove,
    
    /*
     * Menu
     */
    ImageForMenuLblAmount,
    ImageForMenuBtnOrder,
    // Categories
    ImageForCatStateNormal,
    ImageForCatStateRed,
    ImageForCatStateYellow,
    // Dishes
    ImageForDishCellBg,
    ImageForDishCellModif,
    ImageForDishCellIconReady,
    ImageForDishCellIconWait,
    ImageForDishCellIconServed,
    
    /*
     * Staff
     */
    ImageForAdminStaffHeader,
    
    /*
     * Orders
     */
    ImageForGalleryMainSegmentPhoto,
    ImageForGalleryMainSegmentPhotoS,
    ImageForGalleryMainSegmentVideo,
    ImageForGalleryMainSegmentVideoS,
    ImageForOrdersCellBg,
    ImageForOrdersCellInactiveBg,
    ImageForOrdersTableBusy,
    ImageForOrdersTableWait,
    ImageForOrdersTableInact,
    ImageForOrdersInfoFrame,
     // Order
    ImageForOrderBtnAdd,
    ImageForOrderBtnOrder,
    ImageForOrderBtnCalc,
    ImageForOrderBtnReady,
    // Calc
    ImageForCalcBtnConfirm,
    ImageForCalcBtnDiscount,
    ImageForCalcBtnTick,
    ImageForCalcBtnTickS,
    ImageForCalcLblAmount,
    ImageForCalcLblDiscount,
    
    /*
     * Notices
     */
    ImageForNoticesIconAdmin,
    ImageForNoticesIconBar,
    ImageForNoticesIconKitchen,
    ImageForNoticesIconUnfulfilled,
    ImageForNoticesIconFulfilled,
    ImageForNoticesTableBg,
    ImageForNoticesTableSeparator,
    
} ImageFor;

#pragma mark -FontFor enum
typedef enum {
    
    /*
     * General
     */
    FontForLblAmount,
    FontForVirtTableTitle,
    FontForVirtTableDishCnt,
    
    // Detail view
    FontForDetailTitle,
    FontForDetailText,
    
    /*
     * Auth
     */
    FontForAuthLblError,
    
    /*
     * Halls
     */
    FontForHallsTableTitle,
    FontForHallsWaiterName,
    FontForHallsCellTitle,
    
    /*
     * Menu
     */
    FontForDishCellTitle,
    FontForDishCellCost,
    FontForDishCellWeight,
    FontForDishCellCount,
    FontForMenuDishesTitle,
    // Dish
    FontForDishContentTitles,
    FontForDishContentText,
    FontForDishTfModif,
    
    /*
     * Staff
     */
    FontForStaffFullname,
    FontForStaffPost,
    FontForStaffState,
    FontForStaffTimeIn,
    FontForStaffTimeOut,
    
    /*
     * Orders
     */
    FontForOrdersTableNum,
    FontForOrdersAmount,
    FontForOrdersTime,
    FontForOrdersPercent,
    FontForOrdersFee,
    // Filters
    FontForOrdersFiltersNames,
    FontForOrdersFiltersTfText,
    // Info
    FontForOrdersInfoTitles,
    FontForOrdersInfoValues,
    // Edit
    FontForOrderEditBtns,
    // Calc
    FontForCalcLblAmount,
    FontForCalcLblDiscount,
    FontForCalcLblClient,

    /*
     * Notices
     */
    FontForNoticesCellTitle,
    // Admin
    FontForAdminNoticesCellTitle,
    FontForAdminNoticesCellSubtitle,
    
} FontFor;

#pragma mark -TextFor enum
typedef enum {
    
    /*
     * General
     */
    TextForBlankAudioFileName,
    TextForCurrency,
    TextForWeightUnit,
    TextForTimeUnit,
    TextForToolbarBtnDone,
    TextForVirtTableTitle,
    // Alert
    TextForAlertGetAuthFail,
    TextForAlertErrorMess,
    TextforAlertUnavailableUserType,
    TextForAlertDishLimit,
    TextForAlertDishCantDel,
    TextForAlertMakeOrderFalse,
    TextForAlertNoticeMarkReadFailed,
    
    /*
     * TabBar
     */
    TextForTabBarItemTables,
    TextForTabBarItemMenu,
    TextForTabBarItemStaff,
    TextForTabBarItemOrders,
    TextForTabBarItemNotices,
    
    /*
     * API
     */
    // General
    TextForApiItemsSeparator,
    // Functions
        // Auth
    TextForApiFuncAuth,
    TextForApiFuncGetUserRole,
        // Halls
    TextForApiFuncHalls,
    TextForApiFuncTablesFormat,
    TextForApiFuncGetTableFormat,
        // Menu
    TextForApiFuncMenuItemFormat,
    TextForApiFuncMenuCats,
    TextForApiFuncMenuForDishes,
    TextForApiFuncMenuDishesFormat,
    TextForApiFuncMenuDishesWithOrderFormat,
    TextForApiFuncGetDishFormat,
        // Orders
    TextForApiFuncGetOrders,
    TextForApiFuncGetOrderSumFormat,
    TextForApiFuncGetOrderByTableFormat,
    TextForApiFuncGetOrderByIdFormat,
    TextForApiFuncGetModListFormat,
    TextForApiFuncAddItemToReservFormat,
    TextForApiFuncCloneOrderItemFormat,
    TextForApiFuncDelDishFromReservFormat,
    TextForApiFuncMakeOrderFormat,
    TextForApiFuncGetItemByTableAndMenuFormat,
    TextForApiFuncAddModToOrderItemFormat,
    TextForApiFuncDelModFromOrderItemFormat,
        // Notifies
    TextForApiFuncGetNotifies,
    TextForApiFuncMarkNotifyRead,
    TextForApiFuncGetUnreadNoticeCnt,
    // Base url
    TextForAPIBaseURL,
    // Keys
    TextForApiKeyResult,
    TextForApiKeyCountCategory,
    TextForApiKeyCellColor,
    TextForApiKeyId,
    TextForApiKeyIdTable,
        // Halls
    TextForApiKeyRoomNumber,
    TextForApiKeyTableState,
        // Menu
    TextForApiKeyIdMenu,
    TextForApiKeyMenuItemName,
        // Orders
    TextForApiKeyOrderId,
    TextForApiKeyIsOrderCheckExist,
    TextForApiKeyOrderCloseTime,
    TextForApiKeyOrderTableId,
    TextForApiKeyOrderTableNum,
    TextForApiKeyOrderDiscount,
    TextForApiKeyOrderDiscountSum,
    TextForApiKeyIdOrderItems,
    TextForApiKeyOrderItemsIds,
    TextForApiKeyOrderItemState,
    TextForApiKeyOrderItemIdMods,
    TextForApiKeyOrderItemModIds,
    TextForApiKeyOrderItemModNames,
    TextForApiKeyModCnt,
        // Notifies
    TextForApiKeyNotifyType,
    TextForApiKeyNotifyMess,
    TextForApiKeyNotifyState,
    
    TextForApiKeyName,
    TextForApiKeyTitle,
    TextForApiKeyNumber,
    TextForApiKeyHallNumber,
    TextForApiKeyHidden,
    TextForApiKeyDesc,
    TextForApiKeyPausePrepare,
    
    TextForApiKeyWaiter,
    TextForApiKeyImage,
    TextForApiKeyCost,
    TextForApiKeyAmount,
    TextForApiKeyPercent,
    TextForApiKeyFee,
    TextForApiKeyWeight,
    TextForApiKeyPortionWeight,
    TextForApiKeyModifExist,
    TextForApiKeyCount,
    TextForApiKeyTime,
    TextForApiKeyTableNum,
    TextForApiKeyType,
    TextForApiKeyState,
    TextForApiKeySubtitle,
    //
    //
    TextForApiKeyCatId,
    //
    TextForApiKeyCookTime,
    TextForApiKeyModifs,
    TextForApiKeyModifItems,
    //
    TextForApiKeyOrderState,
    TextForApiOrderStateActive,
    TextForApiOrderStateInactive,
    //
    TextForApiKeyDishName,
    TextForApiKeyDishState,
    TextForApiDishStateWait,
    TextForApiDishStateReady,
    TextForApiDishStateServed,
    
    /*
     * Auth
     */
    TextForAuthLoginCap,
    TextForAuthPassCap,
    TextForAuthLoginKey,
    TextForAuthPassKey,
    TextForAuthAlertTitle,
    TextForAuthAlertCancel,
    TextForAuthAlertMessBadUserType,
    
    /*
     * Halls
     */
    TextForHallsTitleFormat,
    TextForHallsFirstHallName,
    
    /*
     * Menu
     */
    TextForMenuTitleFormat,
    TextForDishCellTitleFormat,
    TextForDishCellCostFormat,
    TextForDishCellWeightFormat,
    // Dish
    TextForDishPageTitleFormat,
    TextForDishWeightTitle,
    TextForDishWeightValueFormat,
    TextForDishCookTimeTitle,
    TextForDishCookTimeValueFormat,
    TextForDishDescTitle,
    
    /*
     * Orders
     */
    TextForOrdersTitleActive,
    TextForOrdersTitleAll,
    TextForOrdersAmountFormat,
    TextForOrdersTimeFormat,
    TextForOrdersPercentFormat,
    TextForOrdersFeeFormat,
    //Order
    TextForOrderTitleFormat,
    TextForOrderEditBtnDelete,
    TextForOrderEditBtnMove,
    // Calc
    TextForOrderCalcTitle,
    TextForOrderCalcDiscountPercent,
    TextForOrderCalcClientName,

    /*
     * Notices
     */
    TextForAdminNoticesCellTitleFormat,
    TextForAdminNoticesCellSubtitleFormat,
    
    TextForAuthRoleKey
    
} TextFor;

#pragma mark -PointFor enum
typedef enum {
    
    PointForItem,
    
} PointFor;

#pragma mark -SizeFor enum
typedef enum {
    
    /*
     * Dishes
     */
    SizeForDishCellBtn,
    
} SizeFor;

#pragma mark -RectFor enum
typedef enum {
    /*
     * Auth
     */
    RectForAuthTfLogin,
    RectForAuthTfPass,
    
    
    // Detail view
    RectForDetailTitle,
    RectForDetailPicView,
    RectForDetailTextView,
    RectForDetailImgBottom,
    
    /*
     * Menu
     */
    RectForDishCellTitle,
    RectForDishCellCost,
    RectForDishCellWeight,
    RectForDishCellCount,
    // Dish
    
    // Orders
//    RectForOrdersWaiterPercent,

} RectFor;

#pragma mark -ShadowFor enum
typedef enum {
    
    /*
     * Halls
     */
    ShadowForHallsTableTitle,
    
    /*
     * Orders
     */
    ShadowForOrdersAmount,
    
} ShadowFor;

#pragma mark -ColorFor enum
typedef enum {
    
    /*
     * General
     */
    ColorForViewsBgDebug,
    ColorForLblAmount,
    ColorForVirtTableTitle,
    ColorForVirtTableDishCnt,
    
    /*
     * TabBar
     */
    ColorForTabBarItemTitle,
    ColorForTabBarItemTitleS,

    /*
     * NavBar
     */
    ColorForNavBarTitle,
    ColorForNavBarTitleShadow,
    
    /*
     * Auth
     */
    ColorForAuthLblError,

    /*
     * Halls
     */
    ColorForHallsPageIndicator,
    ColorForHallsPageIndicatorS,
    ColorForHallsTableTitle,
    ColorForHallsCellTitle,
    
    /*
     * Menu
     */
    ColorForDishCellTitle,
    ColorForDishCellCost,
    ColorForDishCellWeight,
    ColorForDishCellCount,
    ColorForMenuDishesTitle,
    // Dish
    ColorForDishContent,
    
    /*
     * Staff
     */
    ColorForStaffCellBg,
    ColorForStaffLines,
    ColorForStaffFullname,
    ColorForStaffPost,
    ColorForStaffState,
    ColorForStaffTimeIn,
    ColorForStaffTimeOut,
    
    /*
     * Orders
     */
    ColorForOrdersAmount,
    ColorForOrdersTime,
    ColorForOrdersPercent,
    ColorForOrdersFee,
    // Filters
    ColorForOrdersFiltersNames,
    ColorForOrdersFiltersTfText,
    // Info
    ColorForOrdersInfoTitles,
    ColorForOrdersInfoValues,
    // Edit
    ColorForOrderEditBtnDelete,
    ColorForOrderEditBtnMove,
    ColorForOrderEditBtnsS,
    // Calc
    ColorForCalcLblAmount,
    ColorForCalcLblDiscount,
    ColorForCalcLblClient,
    
    /*
     * Notices
     */
    ColorForNoticesCellTitle,
    // Admin
    ColorForAdminNoticesCellBg,
    ColorForAdminNoticesCellTitle,
    ColorForAdminNoticesCellSubtitle,
    
} ColorFor;

#pragma mark -AlphaFor enum
typedef enum {
  AlphaForViewsBg
} AlphaFor;

#pragma mark -CorrectionFor enum
typedef enum {
    
    /*
     * General
     */
    CorrectionForLblHeightFromFontSize,
    
    /*
     * Tables
     */
    CorrectionForHallsPageControlTop,

    
    // detail view
    CorrectionForDetailTextHeight,
    CorrectionForDetailScrollViewHeight,
    CorrectionForDetailImgPageControlTop,
    
    /*
     * Halls
     */
    CorrectionForHallsWaiterVertMiddle,
    
    /*
     * Menu
     */
    // Dish
    CorrectionForDishWeightValTop,
    
    /*
     * Orders
     */
    CorrectionForOrdersAmountTop,
    CorrectionForOrdersTimeTop,
    CorrectionForOrdersPercentLeft,
    CorrectionForOrdersFeeTop,

} CorrectionFor;

#pragma mark -IntegerValue enum
typedef enum {
    
    IntegerValueForItem,
    
} IntegerValueFor;

#pragma mark -FloatValue enum
typedef enum {
    
    /*
     * General
     */
    FloatValueForDistBetweenCells,
    FloatValueForToolbarHeight,
    // virt table
    FloatValueForVirtTableTitleTop,
    FloatValueForVirtTableBtnBottomOffset,
    FloatValueForVirtTableCntCircleDia,
    FloatValueForVirtTableCntCircleTop,
    
    /*
     * API
     */
    FloatValueForCurrencyToGrnCoef,
    
    /*
     * Auth
     */
    FloatValueForAuthCntrsDistVert,
    
    /*
     * Halls
     */
    FloatValueForHallsBtnsVertDist,
    FloatValueForHallsSegmentVertOffset,
    FloatValueForHallsVirtTableTopOffset,
    FloatValueForHallsVirtTableRightOffset,
    FloatValueForHallsBtnMoveRightOffset,
    FloatValueForHallsBtnMoveBottomOffset,
    FloatValueForHallsWaiterLeft,
    // Hall
    FloatValueForHallAdminLeft,
    FloatValueForHallAdminWidth,
    
    /*
     * Menu
     */
    FloatValueForDishContentTop,
    FloatValueForDishFeaturesVertDist,
    FloatValueForModifFieldsVertDist,
    FloatValueForMenuCatsTableWidth,
    // category
    FloatValueForMenuDishesTitleVertOffset,
    FloatValueForDishCellDistBtwViews,
     // Dishes
    FloatValueForDishCellIconShift,
    FloatValueForDishCellBtnRightOffset,
    FloatValueForDishCellBtnsTop,
    FloatValueForDishCellDistBtwBtns,
    //Detail view
    FloatValueForDetailFeaturesLeft,
    
    /*
     * Staff
     */
    FloatValueForStaffVertLineWidth,
    FloatValueForStaffVertLine1Left,
    FloatValueForStaffVertLine2Left,
    FloatValueForStaffVertLine3Left,
    FloatValueForStaffVertLine4Left,
    
    /*
     * Orders
     */
    FloatValueForGalleryMainSegBtnsY,
    FloatValueForOrdersPercentRight,
    FloatValueForOrdersFeeLeft,
    FloatValueForAdminOrdersTableWidth,
    FloatValueForAdminOrdersFiltersHeight,
    // Info
    FloatValueForOrdersInfoTop,
    FloatValueForOrdersInfoRightOffset,
    FloatValueForOrdersInfoItemLeft,
    FloatValueForOrdersInfoItemsOffsetV,
    FloatValueForOrdersInfoDistBtwItems,
    // Filters
    FloatValueForOrdersFiltersTfOffsetH,
    // VirtTable
    FloatValueForOrdersVirtTableRightOffset,
    FloatValueForOrdersVirtTableBottomOffset,
    // Edit
    FloatValueForOrderEditViewLeftOffset,
    FloatValueForOrderEditViewWidth,
    FloatValueForOrderEditViewHeight,
    // Calc
    FloatValueForCalcLblAmountTop,
    FloatValueForCalcControlsVertDist,
    
    /*
     * Notices
     */
    FloatValueForNoticesCornerRadius,
    FloatValueForNoticesCellHorizOffset,
    FloatValueForNoticesSeparatLeft,
    FloatValueForNoticesSeparatRightOffset,
    // Admin
    FloatValueForAdminNoticesDistBtwTitles,
    FloatValueForAdminNoticesSeparatLeft,
    FloatValueForAdminNoticesSeparatRightOffset,

} FloatValueFor;

/*
#pragma mark -LocationCoordinate2DFor enum
typedef enum {
    LocationCoordinate2DForItem
} LocationCoordinate2DFor;
*/

#pragma mark -InsetFor enum
typedef enum {
    
    // Detail view
    InsetForDetailPicImg,
    
    /*
     * Staff
     */
    InsetForStaffTable,

} InsetFor;

#pragma mark -OffsetFor enum
typedef enum {
    
    /*
     * NavBar
     */
    OffsetForNavBarTitleShadow,

    /*
     * Menu
     */
    // Categories
    OffsetForMenuCatState,

} OffsetFor;


@interface Settings : NSObject

+ (Settings *)sharedInstance;

+ (UIColor *)color:(ColorFor)colorForItem;
+ (CGFloat)alpha:(AlphaFor)alphaForItem;
+ (UIImage *)image:(ImageFor)imageForItem;
+ (NSString *)text:(TextFor)textForItem;

+ (NSInteger)integerValue:(IntegerValueFor)integerValueForItem;
+ (CGFloat)floatValue:(FloatValueFor)floatValueForItem;
+ (CGPoint)point:(PointFor)pointForItem;
+ (CGSize)size:(SizeFor)sizeForItem;
+ (CGRect)rect:(RectFor)rectForItem;
+ (UIEdgeInsets)inset:(InsetFor)insetForItem;
+ (CGSize)offset:(OffsetFor)offsetForItem;
+ (CGFloat)correction:(CorrectionFor)correctionForItem;

// font
+ (NSString *)fontName:(FontFor)fontForItem;
+ (CGFloat)fontSize:(FontFor)fontForItem;
+ (UIFont *)font:(FontFor)FontForItem;

// shadow
+ (CGSize)shadowOffset:(ShadowFor)shadowForItem;
+ (CGFloat)shadowOpacity:(ShadowFor)shadowForItem;
+ (CGFloat)shadowRadius:(ShadowFor)shadowForItem;
+ (UIColor *)shadowColor:(ShadowFor)shadowForItem;


#pragma mark - Check device methods

+ (BOOL)isIpad;
+ (BOOL)isIphone3_5inch;
+ (BOOL)isIphoneGreater3_5inch;
+ (BOOL)isSimulator;

// Check system version methods
+ (BOOL)isSysVerGreaterOrEqualTo:(NSString *)ver;
+ (BOOL)isSysVerLessOrEqualTo:(NSString *)sysVer;
+ (BOOL)isSysVerLess7;


#pragma mark - Screen methods

+ (CGFloat)screenWidth;
+ (CGFloat)screenHeight;


#pragma mark - Design elements sizes

+ (CGFloat)statusBarHeight;
+ (CGFloat)navBarHeight;
+ (CGFloat)tabBarHeight;


/*
#pragma mark - Location methods

+ (CLLocationCoordinate2D)locationCoordinate2D:(LocationCoordinate2DFor)locationCoordinate2DForItem;
*/


#pragma mark - UserType

typedef NS_ENUM(NSUInteger, UserType)
{
    UserTypeAdmin,
    UserTypeWaiter,
    UserTypeCook,
    UserTypeBarman,
    UserTypeBookkeeper,
    UserTypeSysAdmin,
    UserTypeBoss
};


#pragma mark - TabBar

typedef NS_ENUM(NSUInteger, TabBarItem)
{
    TabBarItemHalls,
    TabBarItemMenu,
    TabBarItemOrders,
    TabBarItemNotices,
};


#pragma mark - Halls

typedef NS_ENUM(NSUInteger, TableState)
{
    TableStateFree,
    TableStatePreorder,
    TableStateBusy,
};


#pragma mark - Menu
typedef enum {
    
    ALLORDERS,
    ALLORDERSBYDATE,
    ALLORDERSBYEMPLOYEE,
    ALLORDERSBYTABLE,
    ALLCLOSE
    
} SortState;
typedef enum {
    
    MenuCatStateNormal,
    MenuCatStateRed,
    MenuCatStateYellow,
    
} MenuCatState;

typedef NS_ENUM(NSUInteger, OrderItemState) {
    
    OrderItemStatePreordered = 1,
    OrderItemStateAccepted = 0,
    OrderItemStateCooked = 9,
    OrderItemStateGaveAway = 2,
    OrderItemStateGaveCheck = 4,
    OrderItemStateDefrayed = 6,
    OrderItemStateReserved = 7,
};


+ (UIImage *)menuCatImgForId:(NSInteger )catID;
+ (NSArray *)menuCategories;


#pragma mark - Orders

typedef NS_ENUM(NSUInteger, OrderState)
{
    OrderStateActive,
    OrderStateInactive,
};

typedef NS_ENUM(NSUInteger, OrdersFilterType) {
    
    OrdersFilterTypeOrders,
    OrdersFilterTypeDate,
    OrdersFilterTypeTables,
    OrdersFilterTypeWaiters,
};

+ (NSArray *)ordersFiltersItemName;
+ (NSArray *)ordersFiltersOrderTypeItems;
+ (NSArray *)ordersInfoFieldsTitles;


#pragma mark - Notices

typedef enum {
    
    NoticeTypeAdmin,
    NoticeTypeKitchen,
    NoticeTypeBar,
    
} NoticeType;

typedef enum {
    
    NoticeStateUnfulfilled,
    NoticeStateFulfilled,
    
} NoticeState;

@end
