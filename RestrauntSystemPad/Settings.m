#import "Settings.h"


@interface Settings()

@end


@implementation Settings

+ (Settings *)sharedInstance
{
    static Settings *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[Settings alloc] init];
     });
    return sharedInstance;
}


#pragma mark - Public static methods

+ (UIImage *)image:(ImageFor)imageForItem {
    NSArray *imgNamesArr = @[
                             /*
                              * General
                              */
                             @"bg", // ImageForControllerViewBg
                             @"frame_virtual_table", // ImageForVirtTableFrame
                             @"virt_table_btn", // ImageForVirtTableBtn
                             // Detail view
                             @"frame", // ImageForDetailPicDecor
                             
                             /*
                              * TabBar
                              */
                             @"tab_bar_horiz_bg", // ImageForTabBarBg
                              @"tables",  // ImageForTabBarItemTables,
                              @"menu",   // ImageForTabBarItemMenu,
                              @"orders",   // ImageForTabBarItemOrders,
                              @"notice",   // ImageForTabBarItemNotices,
                             
                             /*
                              * NavBar
                              */
                             @"nav_bar_horiz_bg", // ImageForNavBarBg
                             @"btn_back", // ImageForNavBarBtnBack
                           
                             /*
                              * Auth
                              */
                             @"auth_bg", // ImageForAuthBg
                             @"auth_tf_bg", // ImageForAuthTfBg
                             @"auth_btn_enter", // ImageForAuthBtnEnter
                             
                             /*
                              * Halls
                              */
                             @"button_exit", // ImageForHallsBtnLogout
                             @"table_free", // ImageForHallsBtnTable
                             @"table_busy", // ImageForHallsBtnTableBusy
                             @"table_expectation", // ImageForHallsBtnTableWait
                             @"door", // ImageForHallsDoor
                             @"bar", // ImageForHallsBar
                             @"halls_btn_edit", // ImageForHallsBtnEdit
                             @"halls_btn_move", // ImageForHallsBtnMove
                             
                             /*
                              * Menu
                              */
                             @"lbl_amount", // ImageForMenuLblAmount
                             @"btn_order", // ImageForMenuBtnOrder
                             // Categories
                             @"oclock", // ImageForCatStateNormal
                             @"oclock_red", // ImageForCatStateRed
                             @"oclock_yelow", // ImageForCatStateYellow
                             // Dishes
                             @"cell_blyudo", // ImageForDishCellBg
                             @"modification", // ImageForDishCellModif
                             @"buttton_gotovo", // ImageForDishCellIconReady
                             @"buttton_ozhudaniye", // ImageForDishCellIconWait
                             @"buttton_podano", // ImageForDishCellIconServed
                             
                             /*
                              * Staff
                              */
                             @"auth_tf_bg", // ImageForAdminStaffHeader
                             
                             /*
                              * Orders
                              */
                             @"button_photo_m", // ImageForGalleryMainSegmentPhoto
                             @"button_photo_m_s", // ImageForGalleryMainSegmentPhotoS
                             @"button_video_m", // ImageForGalleryMainSegmentVideo
                             @"button_video_m_s", // ImageForGalleryMainSegmentVideoS
                             @"cell_order", // ImageForOrdersCell
                             @"cell_order_inactive", // ImageForOrdersCellInactive
                             @"table_busy_lenta", // ImageForOrdersTableBusy
                             @"table_expectation_lenta", // ImageForOrdersTableWait
                             @"table_lenta_inactive", // ImageForOrdersTableInact
                             @"frame_order_info", // ImageForOrdersInfoFrame
                              // Order
                             @"button_add", // ImageForOrderBtnAdd
                             @"button_zakaz", // ImageForOrderBtnOrder
                             @"button_calc", // ImageForOrderBtnCalc
                             @"btn_ready", // ImageForOrderBtnReady
                            // Calc
                             @"btn_confirm", // ImageForCalcBtnConfirm
                             @"btn_discount", // ImageForCalcBtnDiscount
                             @"btn_tick", // ImageForCalcBtnTick
                             @"btn_tick_s", // ImageForCalcBtnTickS
                             @"lbl_amount_calc", // ImageForCalcLblAmount
                             @"lbl_discount", // ImageForCalcLblDiscount
                             
                             /*
                              * Notices
                              */
                             @"icon_administrator", // ImageForNoticesIconAdmin
                             @"icon_bar", // ImageForNoticesIconBar
                             @"icon_kitchen", // ImageForNoticesIconKitchen
                             @"not_fulfilled", // ImageForNoticesIconUnfulfilled
                             @"performed", // ImageForNoticesIconFulfilled
                             @"notice_bg", // ImageForNoticesTableBg
                             @"separator", // ImageForNoticesTableSeparator
                             
                           ];
    NSString *imgName = [imgNamesArr objectAtIndex:imageForItem];
    
    return [UIImage imageNamed:imgName];
}


+ (NSString *)text:(TextFor)textForItem {
    NSArray *textArr = @[

                            /*
                            * General
                            */
                            @"5min_blank.mp3", // TextForBlankAudioFileName
                            @"грн", // TextForCurrency
                            @"г", // TextForWeightUnit
                            @"мин", // TextForTimeUnit
                            @"Готово", // TextForToolbarBtnDone
                            @"Виртуальный\nстол", // TextForVirtTableTitle
                            // Alert
                            @"Authorization failed", // TextForAlertGetAuthFail
                            @"Failed to retrieve data", // TextForAlertErrorMess
                            @"Unavailable user type", // TextforAlertUnavailableUserType
                            @"The dish limit is exceeded", // TextForAlertDishLimit
                            @"Couldn't remove dish", // TextForAlertDishCantDel
                            @"Couldn't make order. Try again later", // TextForAlertMakeOrderFalse
                            @"Couldn't mark notice as read. Try again later", // TextForAlertNoticeMarkReadFailed
                            
                            /*
                            * TabBar
                            */
                            @"Столы", // TextForTabBarItemTables
                            @"Меню", // TextForTabBarItemMenu
                            @"Персонал", // TextForTabBarItemStaff
                            @"Заказы", // TextForTabBarItemOrders
                            @"Уведомления", // TextForTabBarItemNotices

                            /*
                            * API
                            */
                            // General
                            @",", // TextForApiItemsSeparator
                            // Functions
                                // Auth
                            @"AUTH", // TextForApiFuncAuth
                            @"GetUserRole", // TextForApiFuncGetUserRole
                                // Halls
                            @"GETROOMS", // TextForApiFuncHalls
                            @"gettablelist/%d", // TextForApiFuncTablesFormat
                            @"GetTable/%i", // TextForApiFuncGetTableFormat
                                // Menu
                            @"GETMENU", // TextForApiFuncMenuItemFormat
                            @"GETSUBMENU", // TextForApiFuncMenuCats
                            @"GETDISHES", // TextForApiFuncMenuForDishes
                            @"GETDISH", // TextForApiFuncMenuDishesFormat
                            @"GetMenuListWithOrderedItems/%d/%d", // TextForApiFuncMenuDishesWithOrderFormat
                            @"GetMenuItem/%d", // TextForApiFuncGetDishFormat
                                // Orders
                            @"GetOrders", // TextForApiFuncGetOrders
                            @"GetOrderSum/%d", // TextForApiFuncGetOrderSumFormat
                            @"GetPackOrderListByTable/%d", // TextForApiFuncGetOrderByTableFormat
                            @"GetOrderListByOrderID/%i", // TextForApiFuncGetOrderByIdFormat
                            @"GetModList/%d", // TextForApiFuncGetModListFormat
                            @"AddItemToReserv/%d/%d/%d", // TextForApiFuncAddItemToReservFormat
                            @"CloneOrderItem/%d", // TextForApiFuncCloneOrderItemFormat
                            @"DelItemFromReserv/%d", // TextForApiFuncDelDishFromReservFormat
                            @"MAKEORDER", // TextForApiFuncMakeOrderFormat
                            @"GetOrderMenuItemByTable/%i/%i", // TextForApiFuncGetItemByTableAndMenuFormat
                            @"AddModToOrderItem/%i/%i", // TextForApiFuncAddModToOrderItemFormat
                            @"DelModFromOrderItem/%i/%i", // TextForApiFuncDelModFromOrderItemFormat
                                // Notices
                            @"GETNOTIFY", // TextForApiFuncGetNotifies
                            @"MarkEventAsRead/%i", // TextForApiFuncMarkNotifyRead
                            @"GETUNREADNOTIFYCOUNT", // TextForApiFuncGetUnreadNoticeCnt
                            // base url
                            //@"http://10.0.1.200:8080/datasnap/rest/tservermethods1/", // TextForAPIBaseURL
                            HTTP, // TextForAPIBaseURL
                            // Keys
                            @"result", // TextForApiKeyResult
                            @"CountCategory", // TextForApiKeyCountCategory
                            @"CellColor", // TextForApiKeyCellColor
                            @"ID", // TextForApiKeyId
                            @"id_table", // TextForApiKeyIdTable
                                // Halls
                            @"ROOM_ID", // TextForApiKeyRoomNumber
                            @"ID_STATE", // TextForApiKeyTableState
                                // Menu
                            @"ID_MENU", // TextForApiKeyIdMenu
                            @"MENU_ITEM_NAME", // TextForApiKeyMenuItemName
                                // Orders
                            @"ORDER_ID", // TextForApiKeyOrderId
                            @"CHEK", // TextForApiKeyIsOrderCheckExist
                            @"TIME_CHECK", // TextForApiKeyOrderCloseTime
                            @"TABLE_ID", // TextForApiKeyOrderTableId
                            @"TABLE_NOMER", // TextForApiKeyOrderTableNum
                            @"DISCOUNT", // TextForApiKeyOrderDiscount
                            @"SUMM_DISCOUNT", // TextForApiKeyOrderDiscountSum
                            @"ID_ORDER_ITEMS", // TextForApiKeyIdOrderItems
                            @"ORDER_ITEMS_IDS", // TextForApiKeyOrderItemsIds
                            @"ID_PREPARE_STATE", // TextForApiKeyOrderItemState
                            @"ID_MODS", // TextForApiKeyOrderItemIdMods
                            @"MOD_IDS", // TextForApiKeyOrderItemModIds
                            @"MOD_NAMES", // TextForApiKeyOrderItemModNames
                            @"MOD_COUNT", // TextForApiKeyModCnt
                                // Notifies
                            @"MESSAGE_TYPE", // TextForApiKeyNotifyType
                            @"MESSAGE", // TextForApiKeyNotifyMess
                            @"IS_READ", // TextForApiKeyNotifyState
                               //
                            @"NAME", // TextForApiKeyName
                            @"title", // TextForApiKeyTitle
                            @"NOMER", // TextForApiKeyNumber
                            @"hall_number", // TextForApiKeyHallNumber
                            @"IS_HIDDEN", // TextForApiKeyHidden
                            @"DESCRIPTION", // TextForApiKeyDesc
                            @"PausePrepare", // TextForApiKeyPausePrepare
                            
                            @"WAITER", // TextForApiKeyWaiter
                            @"image", // TextForApiKeyImage
                            @"PRICE", // TextForApiKeyCost
                            @"AMOUNT", // TextForApiKeyAmount
                            @"waiter_amount", // TextForApiKeyWaiterFee
                            @"percent", // TextForApiKeyWaiterPercent
                            @"QUANTITY", // TextForApiKeyWeight
                            @"PORTION_WEIGHT", // TextForApiKeyPortionWeight
                            @"modif_exist", // TextForApiKeyModifExist
                            @"COUNT", // TextForApiKeyCount
                            @"time", // TextForApiKeyTime
                            @"table_num", // TextForApiKeyTableNum
                            @"type", // TextForApiKeyType
                            @"state", // TextForApiKeyState
                            @"subtitle", // TextForApiKeySubtitle
                            // Halls
                            // Menu
                            @"ID_CATEGORY", // TextForApiKeyCatId
                            // Dish
                            @"PREPARATION_TIME", // TextForApiKeyCookTime
                            @"modifs", // TextForApiKeyModifs
                            @"modif_items", // TextForApiKeyModifItems
                            // Orders
                            @"order_state", // TextForApiKeyOrderState
                            @"active", // TextForApiOrderStateActive
                            @"inactive", // TextForApiOrderStateInactive
                            // Order
                            @"MENU_ITEM_NAME", // TextForApiKeyDishName
                            @"dish_state", // TextForApiKeyDishState
                            @"dish_state_wait", // TextForApiDishStateWait
                            @"dish_state_ready", // TextForApiDishStateReady
                            @"dish_state_served", // TextForApiDishStateServed

                            /*
                            * Auth
                            */
                            @"Логин", // TextForAuthLoginCap
                            @"Пароль", // TextForAuthPassCap
                            @"login", // TextForAuthLoginKey
                            @"password", // TextForAuthPassKey
                            @"Сообщение", // TextForAuthAlertTitle
                            @"OK", // TextForAuthAlertCancel
                            @"Not available user type", // TextForAuthAlertBadUserType

                            /*
                            * Halls
                            */
                            @"Зал %d", // TextForTablesTitleFormat
                            @"1", // TextForHallsFirstHallName

                            /*
                            * Menu
                            */
                            @"Стол %@ (%@)", // TextForMenuTitleFormat
                            @"« %@ »", // TextForDishCellTitleFormat
                            @"%d %@", // TextForDishCellCostFormat
                            @"%d %@", // TextForDishCellWeightFormat
                            // Dish
                            @"«%@»", // TextForDishPageTitleFormat
                            @"Вес:", // TextForDishWeightTitle
                            @"%@ %@", // TextForDishWeightValueFormat
                            @"Время приготовления:", // TextForDishCookTimeTitle
                            @"%@ %@", // TextForDishCookTimeValueFormat
                            @"Описание:", // TextForDishDescTitle

                            /*
                            * Orders
                            */
                            @"Текущие заказы", // TextForOrdersTitleActive
                            @"Все заказы", // TextForOrdersTitleAll
                            @"%d %@", // TextForOrdersAmountFormat
                            @"%i:%i", // TextForOrdersTimeFormat
                            @"%d%%", // TextForOrdersPercentFormat
                            @"%.2f %@", // TextForOrdersFeeFormat
                            // Order
                            @"Стол %@ (%@)", // TextForOrderTitleFormat
                            @"Удалить", // TextForOrderEditBtnDelete
                            @"Переместить", // TextForOrderEditBtnMove
                            // Calc
                            @"Расчет", // TextForOrderCalcTitle
                            @"0 %", // TextForOrderCalcDiscountPercent
                            @"Гость", // TextForOrderCalcClientName
                            
                            /*
                             * Notices
                             */
                            @"%@!", // TextForAdminNoticesCellTitleFormat
                            @"(%@)", // TextForAdminNoticesCellSubtitleFormat
                            
                            @"userRole",//TextForAuthRoleKey

                        ];
    return [textArr objectAtIndex:textForItem];
}

+ (CGPoint)point:(PointFor)pointForItem {

    NSArray *pointArr = @[
                             [NSValue valueWithCGPoint:CGPointMake(0.f, 0.f)] //
                         ];
    NSValue *pointValue = [pointArr objectAtIndex:pointForItem];
    
    return [pointValue CGPointValue];
}

+ (CGSize)size:(SizeFor)sizeForItem {
    
    NSArray *sizeArr = @[
                         
                         /*
                          * Dishes
                          */
                         [NSValue valueWithCGSize:CGSizeMake(38.f, 40.f)], // SizeForDishCellBtn

                          ];
    NSValue *sizeValue = [sizeArr objectAtIndex:sizeForItem];

    return [sizeValue CGSizeValue];
}

+ (CGRect)rect:(RectFor)RectForItem {
    NSArray *fontSizesArr = @[
                              /*
                               * Auth
                               */
                              // RectForAuthTfLogin
                              [NSValue valueWithCGRect:CGRectMake(0.f,
                                                                  100.f,
                                                                  200.f,
                                                                  30.f)],
                              // RectForAuthTfPass
                              [NSValue valueWithCGRect:CGRectMake(0.f,
                                                                  150.f,
                                                                  200.f,
                                                                  30.f)],
                              
                              // Detail view
                              [NSValue valueWithCGRect:CGRectMake(0, 10.f, 285.f, 0.f)], // RectForDetailTitle
                              [NSValue valueWithCGRect:CGRectMake(0.f, 0.f, 285.f, 218.f)], // RectForDetailPicView, 285 × 218 frame
                              // RectForDetailTextView
                              [NSValue valueWithCGRect:CGRectMake(([Settings screenWidth] - 285.f) / 2,
                                                                  40.f + 200.f + 5.f,
                                                                  285.f,
                                                                  0.f)],
                              // RectForDetailImgBottom
                              [NSValue valueWithCGRect:CGRectMake(([Settings screenWidth] - 285.f) / 2, 0.f, 285.f, 200.f)],
                              
                              /*
                               * Menu
                               */
                               // RectForDishCellTitle
                              [NSValue valueWithCGRect:CGRectMake(40.f,
                                                                  30.f,
                                                                  220.f,
                                                                  [Settings fontSize:FontForDishCellTitle] * 2  + [Settings correction:CorrectionForLblHeightFromFontSize] * 2)],
                              // RectForDishCellCost
                              [NSValue valueWithCGRect:CGRectMake(70.f,
                                                                  85.f,
                                                                  190.f,
                                                                  [Settings fontSize:FontForDishCellCost] + [Settings correction:CorrectionForLblHeightFromFontSize])],
                              // RectForDishCellWeight
                              [NSValue valueWithCGRect:CGRectMake(12.f,
                                                                  95.5f,
                                                                  50.f,
                                                                  [Settings fontSize:FontForDishCellWeight] + [Settings correction:CorrectionForLblHeightFromFontSize])],
                              // RectForDishCellCount
                              [NSValue valueWithCGRect:CGRectMake(238.5f,
                                                                  57.0f,
                                                                  50.f,
                                                                  [Settings fontSize:FontForDishCellCount] + [Settings correction:CorrectionForLblHeightFromFontSize])],
                              // Dish
                              //--------
                              
                              // Orders
                              // RectForOrdersWaiterPercent
//                              [NSValue valueWithCGRect:CGRectMake(0.f,
//                                                                  39.75f,
//                                                                  50.f,
//                                                                  [Settings fontSize:FontForDishCellCount] + [Settings correction:CorrectionForLblHeightFromFontSize])],
                              
                              ];
    NSValue *rectValue = [fontSizesArr objectAtIndex:RectForItem];
    
    return [rectValue CGRectValue];
}

+ (UIColor *)color:(ColorFor)colorForItem
{
    NSArray *colorsArr = @[
                           
                           /*
                            * General
                            */
                           // only one
                           //[UIColor colorWithRed:211.f/255.f green:211.f/255.f blue:211.f/255.f alpha:1.f], // ColorForViewsBgDebug
                           [UIColor colorWithRed:211.f/255.f green:211.f/255.f blue:211.f/255.f alpha:0.f], // ColorForViewsBgDebug
                           
                           [UIColor grayColor], // ColorForLblAmount
                           [UIColor blueColor], // ColorForVirtTableTitle
                           [UIColor whiteColor], // ColorForVirtTableDishCnt
                           
                           /*
                            * TabBar
                            */
                           [UIColor whiteColor], // ColorForTabBarItemTitle
                           [UIColor blueColor], // ColorForTabBarItemTitleS
                           
                           /*
                            * NavBar
                            */
                           [UIColor whiteColor], // ColorForNavBarTitle
                           [UIColor blackColor], // ColorForNavBarTitleShadow
                           
                           /*
                            * Auth
                            */
                           [UIColor redColor], // ColorForAuthLblError
                          
                           /*
                            * Halls
                            */
                           [UIColor lightGrayColor], // ColorForHallsPageIndicator
                           [UIColor whiteColor], // ColorForHallsPageIndicatorS
                           [UIColor brownColor], // ColorForHallsTableTitle
                           [UIColor blackColor], // ColorForHallsCellTitle
                           
                           /*
                            * Menu
                            */
                           [UIColor whiteColor], // ColorForDishCellTitle
                           [UIColor whiteColor], // ColorForDishCellCost
                           [UIColor whiteColor], // ColorForDishCellWeight
                           [UIColor blackColor], // ColorForDishCellCount
                           [UIColor blueColor], // ColorForMenuDishesTitle
                           // Dish
                           [UIColor whiteColor], // ColorForDishContent
                           
                           /*
                            * Staff
                            */
                           [UIColor whiteColor], // ColorForStaffCellBg
                           [UIColor lightGrayColor], // ColorForStaffLines
                           [UIColor blackColor], // FontForStaffFullname
                           [UIColor blackColor], // FontForStaffPost
                           [UIColor blackColor], // FontForStaffState
                           [UIColor blackColor], // FontForStaffTimeIn
                           [UIColor blackColor], // FontForStaffTimeOut

                           /*
                            * Orders
                            */
                           [UIColor whiteColor], // ColorForOrdersAmount
                           [UIColor lightGrayColor], // ColorForOrdersTime
                           [UIColor blackColor], // ColorForOrdersPercent
                           [UIColor whiteColor], // ColorForOrdersFee
                           // Filters
                           [UIColor blueColor], // ColorForOrdersFiltersNames
                           [UIColor lightGrayColor], // ColorForOrdersFiltersTfText
                           // Info
                           [UIColor blueColor], // ColorForOrdersInfoTitles
                           [UIColor grayColor], // ColorForOrdersInfoValues
                           // Edit
                           [UIColor redColor], // ColorForOrderEditBtnDelete
                           [UIColor blueColor], // ColorForOrderEditBtnMove
                           [UIColor lightGrayColor], // ColorForOrderEditBtnsS
                           // Calc
                           [UIColor darkGrayColor], // ColorForCalcLblAmount
                           [UIColor darkGrayColor], // ColorForCalcLblDiscount
                           [UIColor whiteColor], // ColorForCalcLblClient
                           
                           /*
                            * Notices
                            */
                           [UIColor whiteColor], // ColorForNoticesCellTitle
                           // Admin
                           [UIColor colorWithRed:0.f/255.f green:0.f/255.f blue:0.f/255.f alpha:0.3f], // ColorForAdminNoticesCellBg
                           [UIColor redColor], // ColorForAdminNoticesCellTitle
                           [UIColor blueColor], // ColorForAdminNoticesCellSubtitle
                           
                           ];
    
    return [colorsArr objectAtIndex:colorForItem];
}

+ (CGSize)offset:(OffsetFor)offsetForItem {
    NSArray *offsetsArr = @[
                            
                            /*
                             * NavBar
                             */
                            [NSValue valueWithCGSize:CGSizeMake(0.f, 1.f)], // OffsetForNavBarTitleShadow
                            
                            /*
                             * Menu
                             */
                            // Categories
                            [NSValue valueWithCGSize:CGSizeMake(-5.f, 5.f)], // OffsetForMenuCatState
                            
                            ];
    NSValue *offsetValue = [offsetsArr objectAtIndex:offsetForItem];
    
    return [offsetValue CGSizeValue];
}

+ (CGFloat)alpha:(AlphaFor)alphaForItem {
    
    NSArray *alphaArr = @[
                               @0.f // 
                               ];
    NSNumber *alphaNumber = [alphaArr objectAtIndex:alphaForItem];
    
    return [alphaNumber floatValue];
}

+ (CGFloat)correction:(CorrectionFor)correctionForItem
{
    NSArray *correctionArr = @[
                               
                               /*
                                * General
                                */
                               [NSNumber numberWithFloat:5.f], // CorrectionForLblHeightFromFontSize
                               
                               /*
                                * Tables
                                */
                               // CorrectionForHallsPageControlTop,
                               @-80.f,

                                
                                // detail view
                                // CorrectionForDetailTextHeight
                                [NSNumber numberWithFloat:25.f],
                                // CorrectionForDetailScrollViewHeight
                                [NSNumber numberWithFloat:10.f],
                                // CorrectionForDetailImgPageControlTop
                                [NSNumber numberWithFloat:[Settings isSimulator] ? -30.f : -20.f],
                                
                                /*
                                 * Halls
                                 */
                                [NSNumber numberWithFloat:-14.f], // CorrectionForHallsWaiterVertMiddle
                           
                               /*
                                * Menu
                                */
                               // Dish
                               [NSNumber numberWithFloat:-1.5f], // CorrectionForDishWeightValTop
                           
                               /*
                                * Orders
                                */
                                [NSNumber numberWithFloat:-5.f], // CorrectionForOrdersAmountTop
                                [NSNumber numberWithFloat:-8.f], // CorrectionForOrdersTimeTop
                               [NSNumber numberWithFloat:-10.f], // CorrectionForOrdersPercentRight
                               [NSNumber numberWithFloat:-10.f], // CorrectionForOrdersFeeTop

                               ];
    NSNumber *correctionNumber = [correctionArr objectAtIndex:correctionForItem];
    
    return [correctionNumber floatValue];
}

+ (NSInteger)integerValue:(IntegerValueFor)integerValueForItem
{
    
    NSArray *integerValuesArr = @[
                                @6 //
                                ];
    NSNumber *integerValueNumber = [integerValuesArr objectAtIndex:integerValueForItem];
    
    return [integerValueNumber integerValue];
}

+ (CGFloat)floatValue:(FloatValueFor)floatValueForItem {
    
    NSArray *floatValuesArr = @[
                                
                                /*
                                 * General
                                 */
                                @10.f, // FloatValueForDistBetweenCells
                                @44.f, // FloatValueForToolbarHeight
                                // Virt Table
                                @20.f, // FloatValueForVirtTableTitleTop
                                @20.f, // FloatValueForVirtTableBtnBottomOffset
                                @20.f, // FloatValueForVirtTableCntCircleDia
                                @5.f, // FloatValueForVirtTableCntCircleTop
                                
                                /*
                                 * API
                                 */
                                @(1/100.f), // FloatValueForCurrencyToGrnCoef
                                
                                /*
                                 * Auth
                                 */
                                @10.f, // FloatValueForAuthCntrsDistVert
                                
                                /*
                                 * Halls
                                 */
                                [Settings isIpad] ? @75.f : @30.f, // FloatValueForHallsBtnsVertDist
                                @10.f, // FloatValueForHallsSegmentVertOffset
                                @30.f, // FloatValueForHallsVirtTableTopOffset
                                @40.f, // FloatValueForHallsVirtTableRightOffset
                                @50.f, // FloatValueForHallsBtnMoveRightOffset
                                @15.f, // FloatValueForHallsBtnMoveBottomOffset
                                @7.f, // FloatValueForHallsWaiterLeft
                                // Hall
                                @300.f, // FloatValueForHallAdminLeft
                                @500.f, // FloatValueForHallAdminWidth
                               
                                /*
                                 * Menu
                                 */
                                @20.f, // FloatValueForDishContentTop
                                @10.f, // FloatValueForDishFeaturesVertDist
                                @10.f, // FloatValueForModifFieldsVertDist
                                @370.f, // FloatValueForMenuCatsTableWidth
                                // category
                                @15.f, // FloatValueForMenuDishesTitleVertOffset
                                @2.f, // FloatValueForDishCellDistBtwViews
                                // Dishes
                                @5.f, // FloatValueForDishCellIconShift
                                @-8.f, // FloatValueForDishCellBtnRightOffset
                                @27.f, // FloatValueForDishCellBtnsTop
                                @3.f, // FloatValueForDishCellDistBtwBtns
                                // Detail view
                                @10.f, // FloatValueForDetailFeaturesLeft
                               
                                /*
                                 * Staff
                                 */
                                @1.f, // FloatValueForStaffVertLineWidth
                                @200.f, // FloatValueForStaffVertLine1Left
                                @400.f, // FloatValueForStaffVertLine2Left
                                @600.f, // FloatValueForStaffVertLine3Left
                                @800.f, // FloatValueForStaffVertLine4Left

                                /*
                                 * Orders
                                 */
                                @10.f, // FloatValueForGalleryMainSegBtnsY
                                @236.f, // FloatValueForOrdersPercentRight
                                @241.f, // FloatValueForOrdersFeeLeft
                                @300.f, // FloatValueForAdminOrdersTableWidth
                                @50.f, // FloatValueForAdminOrdersFiltersHeight
                                // Info
                                @20.f, // FloatValueForOrdersInfoTop
                                @10.f, // FloatValueForOrdersInfoRightOffset
                                @10.f, // FloatValueForOrdersInfoItemLeft
                                @20.f, // FloatValueForOrdersInfoItemsOffsetV
                                @15.f, // FloatValueForOrdersInfoDistBtwItems,
                                // Filters
                                @5.f, // FloatValueForOrdersFiltersTfOffsetH
                                // VirtTable
                                @20.f, // FloatValueForOrdersVirtTableRightOffset
                                @10.f, // FloatValueForOrdersVirtTableBottomOffset
                                // Edit
                                @10.f, // FloatValueForOrderEditViewLeftOffset
                                @450.f, // FloatValueForOrderEditViewWidth
                                @40.f, // FloatValueForOrderEditViewHeight
                                // Calc
                                @10.f, // FloatValueForCalcLblAmountTop
                                @20.f, // FloatValueForCalcControlsVertDist
                                
                                /*
                                 * Notices
                                 */
                                @8.f, // FloatValueForNoticesCornerRadius
                                @20.f, // FloatValueForNoticesCellHorizOffset
                                @15.f, // FloatValueForNoticesSeparatLeft
                                @10.f, // FloatValueForNoticesSeparatRightOffset
                                // Admin
                                @5.f, // FloatValueForAdminNoticesDistBtwTitles
                                @15.f, // FloatValueForAdminNoticesSeparatLeft
                                @15.f, // FloatValueForAdminNoticesSeparatRightOffset
                                
                                ];
    NSNumber *floatValueNumber = [floatValuesArr objectAtIndex:floatValueForItem];
    
    return [floatValueNumber floatValue];
}

+ (UIEdgeInsets)inset:(InsetFor)insetForItem
{
    NSArray *inset = @[
                        // Detail view
                        // InsetsForDetailPicImg
                        [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(8.f, 7.f, 7.f, 8.f)],
                        
                        /*
                         * Staff
                         */
                        [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(20.f, 0.f, 0.f, 0.f)], // InsetForStaffTable

                        ];
    
    NSValue *insetValue = [inset objectAtIndex:insetForItem];
    
    return [insetValue UIEdgeInsetsValue];
}

//+ (UIOffset)offset:(OffsetFor)offsetForItem {
//    
//    NSArray *offsetsArr = @[
//                                [NSValue valueWithUIOffset:UIOffsetMake(0.f, 0.f)] // 
//                            ];
//    NSValue *offsetValue = [offsetsArr objectAtIndex:offsetForItem];
//    
//    return [offsetValue UIOffsetValue];
//}

#pragma mark -Font methods

+ (NSString *)fontName:(FontFor)fontForItem {
    NSArray *imgNamesArr = @[
                             
                             /*
                              * General
                              */
                             @"ArialRoundedMTBold", // FontForLblAmount
                             @"ArialRoundedMTBold", // FontForVirtTableTitle
                             @"ArialRoundedMTBold", // FontForVirtTableDishCnt
                             
                             // Detail view
                             @"ArialRoundedMTBold", // FontForDetailTitle
                             @"ArialRoundedMTBold", // FontForDetailText
                             
                             /*
                              * Auth
                              */
                             @"ArialRoundedMTBold", // FontForAuthLblError
                             
                             /*
                              * Halls
                              */
                             @"ArialRoundedMTBold", // FontForHallsTableTitle
                             @"ArialRoundedMTBold", // FontForHallsWaiterName
                             @"ArialRoundedMTBold", // FontForHallsCellTitle
                            
                             /*
                              * Menu
                              */
                             @"ArialRoundedMTBold", // FontForCellDishTitle
                             @"ArialRoundedMTBold", // FontForDishCellCost
                             @"ArialRoundedMTBold", // FontForDishCellWeight
                             @"ArialRoundedMTBold", // FontForDishCellCount
                             @"ArialRoundedMTBold", // FontForMenuDishesTitle
                             // Dish
                             @"ArialRoundedMTBold", // FontForDishContentTitles
                             @"ArialRoundedMTBold", // FontForDishContentText
                             @"ArialRoundedMTBold", // FontForDishTfModif
                             
                             /*
                              * Staff
                              */
                             @"ArialRoundedMTBold", // FontForStaffFullname
                             @"ArialRoundedMTBold", // FontForStaffPost
                             @"ArialRoundedMTBold", // FontForStaffState
                             @"ArialRoundedMTBold", // FontForStaffTimeIn
                             @"ArialRoundedMTBold", // FontForStaffTimeOut
                             
                             /*
                              * Orders
                              */
                             @"ArialRoundedMTBold", // FontForOrdersTableNum
                             @"ArialRoundedMTBold", // FontForOrdersAmount
                             @"ArialRoundedMTBold", // FontForOrdersTime
                             @"ArialRoundedMTBold", // FontForOrdersPercent
                             @"ArialRoundedMTBold", // FontForOrdersFee
                             // Filters
                             @"ArialRoundedMTBold", // FontForOrdersFiltersNames
                             @"ArialRoundedMTBold", // FontForOrdersFiltersTfText
                             // Info
                             @"ArialRoundedMTBold", // FontForOrdersInfoTitles
                             @"ArialRoundedMTBold", // FontForOrdersInfoValues
                             // Edit
                             @"ArialRoundedMTBold", // FontForOrderEditBtns
                             // Calc
                             @"ArialRoundedMTBold", // FontForCalcLblAmount
                             @"ArialRoundedMTBold", // FontForCalcLblDiscount
                             @"ArialRoundedMTBold", // FontForCalcLblClient
                             
                             /*
                              * Notices
                              */
                             @"ArialRoundedMTBold", // FontForNoticesCellTitle
                             // Admin
                             @"", // FontForAdminNoticesCellTitle
                             @"", // FontForAdminNoticesCellSubtitle

                             ];
    return [imgNamesArr objectAtIndex:fontForItem];
}

+ (CGFloat)fontSize:(FontFor)fontForItem {
    NSArray *fontSizesArr = @[
                              
                              /*
                               * General
                               */
                              @15.f, // FontForLblAmount
                              @12.f, // FontForVirtTableTitle
                              @10.f, // FontForVirtTableDishCnt
                              
                              // Detail view
                              @18.f, // FontForDetailTitle
                              @14.f, // FontForDetailText
                              
                              /*
                               * Auth
                               */
                              @14.f, // FontForAuthLblError
                              
                              /*
                               * Halls
                               */
                              @35.f, // FontForHallsTableTitle
                              @8.f, // FontForHallsWaiterName
                              @20.f, // FontForHallsCellTitle
                             
                              /*
                               * Menu
                               */
                              @17.f, // FontForCellDishTitle
                              @18.f, // FontForDishCellCost
                              @10.f, // FontForDishCellWeight
                              @18.f, // FontForDishCellCount
                              @18.f, // FontForMenuDishesTitle
                              // Dish
                              @17.f, // FontForDishContentTitles
                              @15.f, // FontForDishContentText
                              @15.f, // FontForDishTfModif
                              
                              /*
                               * Staff
                               */
                              @15.f, // FontForStaffFullname
                              @15.f, // FontForStaffPost
                              @15.f, // FontForStaffState
                              @15.f, // FontForStaffTimeIn
                              @15.f, // FontForStaffTimeOut
                              
                              // Orders
                              @26.f, // FontForOrdersTableNum
                              @25.f, // FontForOrdersAmount
                              @10.f, // FontForOrdersTime
                              @10.f, // FontForOrdersPercent
                              @10.f, // FontForOrdersFee
                              // Filters
                              @10.f, // FontForOrdersFiltersNames
                              @10.f, // FontForOrdersFiltersTfText
                              // Info
                              @13.f, // FontForOrdersInfoTitles
                              @13.f, // FontForOrdersInfoValues
                              // Edit
                              @10.f, // FontForOrderEditBtns
                              // Calc
                              @35.f, // FontForCalcLblAmount
                              @28.f, // FontForCalcLblDiscount
                              @25.f, // FontForCalcLblClient
                              
                              /*
                               * Notices
                               */
                              @12.f, // FontForNoticesCellTitle
                              // Admin
                              @12.f, // FontForAdminNoticesCellTitle
                              @12.f, // FontForAdminNoticesCellSubtitle
                              
                              ];
    NSNumber *fontSizeNumber = [fontSizesArr objectAtIndex:fontForItem];
    
    return [fontSizeNumber floatValue];
}

+ (UIFont *)font:(FontFor)FontForItem {
    
    return [UIFont fontWithName:[Settings fontName:FontForItem]
                           size:[Settings fontSize:FontForItem]];
}


#pragma mark - Shadow methods

+ (CGSize)shadowOffset:(ShadowFor)shadowForItem {
    NSArray *shadowOffsetsArr = @[
                                  
                                  /*
                                   * Halls
                                   */
                                    [NSValue valueWithCGSize:CGSizeMake(0.f, -1.f)], // ShadowForHallsTableTitle
                                    
                                    /*
                                     * Orders
                                     */
                                    [NSValue valueWithCGSize:CGSizeMake(0.f, 1.f)], // ShadowForOrdersAmount

                                    ];
    NSValue *shadowOffsetValue = [shadowOffsetsArr objectAtIndex:shadowForItem];
    
    return [shadowOffsetValue CGSizeValue];
}

+ (CGFloat)shadowOpacity:(ShadowFor)shadowForItem {
    NSArray *shadowOpacitiesArr = @[
                                    
                                    /*
                                     * Halls
                                     */
                                    @1.f, // ShadowForHallsTableTitle
                                    
                                    /*
                                     * Orders
                                     */
                                    @1.f, // ShadowForOrdersAmount
                                    
                                    
                                  ];
    NSNumber *shadowOpacityNumber = [shadowOpacitiesArr objectAtIndex:shadowForItem];
    
    return [shadowOpacityNumber floatValue];
}

+ (CGFloat)shadowRadius:(ShadowFor)shadowForItem {
    NSArray *shadowRadiiArr = @[
                                
                                /*
                                 * Halls
                                 */
                                @1.f, // ShadowForHallsTableTitle
                                
                                /*
                                 * Orders
                                 */
                                @1.f, // ShadowForOrdersAmount
                                

                                ];
    NSNumber *shadowRadiusNumber = [shadowRadiiArr objectAtIndex:shadowForItem];
    
    return [shadowRadiusNumber floatValue];
}

+ (UIColor *)shadowColor:(ShadowFor)shadowForItem {
    
    NSArray *colorsArr = @[
                           
                           /*
                            * Halls
                            */
                           [UIColor colorWithRed:0.f/255.f green:0.f/255.f blue:0.f/255.f alpha:1.f], // ShadowForHallsTableTitle
                           
                           /*
                            * Orders
                            */
                           [UIColor colorWithRed:0.f/255.f green:0.f/255.f blue:0.f/255.f alpha:1.f], // ShadowForOrdersAmount
                           
                           
                            ];
    UIColor *shadowColor = [colorsArr objectAtIndex:shadowForItem];
    
    return shadowColor;
}


#pragma mark - Check system version methods

+ (BOOL)isSysVerLessOrEqualTo:(NSString *)ver {
    
    return ([[[UIDevice currentDevice] systemVersion] compare:ver options:NSNumericSearch] != NSOrderedDescending);
}

+ (BOOL)isSysVerGreaterOrEqualTo:(NSString *)ver {
    
    return ([[[UIDevice currentDevice] systemVersion] compare:ver options:NSNumericSearch] != NSOrderedAscending);
}

+ (BOOL)isSysVerLess7
{
    return ![Settings isSysVerGreaterOrEqualTo:@"7.0"];
}


#pragma mark - Check device methods

+ (BOOL)isIpad
{
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
}

+ (BOOL)isIphone3_5inch
{
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone && [Settings screenHeight] == [Settings iphone3_5inchScreenHeight];
}

+ (BOOL)isIphoneGreater3_5inch
{
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone && [Settings screenHeight] > [Settings iphone3_5inchScreenHeight];
}

+ (BOOL)isSimulator
{
    return TARGET_IPHONE_SIMULATOR;
}


#pragma mark - Screen methods

+ (CGFloat)screenWidth
{
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];

    return orientation == UIDeviceOrientationPortrait ? [[UIScreen mainScreen] bounds].size.width
                                                      : [[UIScreen mainScreen] bounds].size.height;
}

+ (CGFloat)screenHeight
{
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];

    return orientation == UIDeviceOrientationPortrait ? [[UIScreen mainScreen] bounds].size.height
                                                      : [[UIScreen mainScreen] bounds].size.width;
}

+ (CGFloat)iphone3_5inchScreenHeight
{
    return 480.f;
}


#pragma mark - Design elements sizes

+ (CGFloat)statusBarHeight
{
    CGSize statusBarSize = [[UIApplication sharedApplication] statusBarFrame].size;
    return MIN(statusBarSize.width, statusBarSize.height);
}

+ (CGFloat)navBarHeight
{
    return [Settings image:ImageForNavBarBg].size.height;
}

+ (CGFloat)tabBarHeight
{
    return [Settings image:ImageForTabBarBg].size.height;
}


/*
#pragma mark - Location methods

+ (CLLocationCoordinate2D)locationCoordinate2D:(LocationCoordinate2DFor)locationCoordinate2DForItem {
    
    NSArray *locationArr = @[
                                [NSValue valueWithCGPoint:CGPointMake(0.0f, 0.0f)] // 
                            ];
    
    NSValue *value = [locationArr objectAtIndex:locationCoordinate2DForItem];
    CGPoint point = [value CGPointValue];
    
    return CLLocationCoordinate2DMake(point.x, point.y);
}
*/


#pragma mark - Menu

+ (UIImage *)menuCatImgForId:(NSInteger )catID
{
    NSString *imgName = EmptyString;
    
    switch (catID){
        case 0 :
            imgName = @"cell_breakfast";
            break;
        case 1 :
            imgName = @"cell_zakuski";
            break;
        case 2 :
            imgName = @"cell_salats";
            break;
        case 3 :
            imgName = @"cell_sup";
            break;
        case 4 :
            imgName = @"cell_blyuda";
            break;
        case 5 :
            imgName = @"cell_pasta";
            break;
        case 6 :
            imgName = @"cell_grill";
            break;
        case 7 :
            imgName = @"cell_garniru";
            break;
        case 8 :
            imgName = @"cell_bread";
            break;
        case 9 :
            imgName = @"cell_sweet";
            break;
        case 10 :
            imgName = @"cell_cofe";
            break;
        case 11 :
            imgName = @"cell_kids";
            break;
        case 12 :
            imgName = @"cell_alco";
            break;
        default:
            imgName = @"cell_alco";
            break;
            
    }
    return [UIImage imageNamed:imgName];
}

+ (NSArray *)menuCategories
{
    return @[
             @{
                 [Settings text:TextForApiKeyId]: [NSNumber numberWithInteger:1],
                 [Settings text:TextForApiKeyTableState]: [NSNumber numberWithInteger:MenuCatStateNormal],
                 [Settings text:TextForApiKeyImage]: [UIImage imageNamed:@"cell_breakfast"],
                 [Settings text:TextForApiKeyTitle]: @"Завтраки",
                 },
             @{
                 [Settings text:TextForApiKeyId]: [NSNumber numberWithInteger:2],
                 [Settings text:TextForApiKeyTableState]: [NSNumber numberWithInteger:MenuCatStateNormal],
                 [Settings text:TextForApiKeyImage]: [UIImage imageNamed:@"cell_zakuski"],
                 [Settings text:TextForApiKeyTitle]: @"Закуски",
                 },
             @{
                 [Settings text:TextForApiKeyId]: [NSNumber numberWithInteger:3],
                 [Settings text:TextForApiKeyTableState]: [NSNumber numberWithInteger:MenuCatStateRed],
                 [Settings text:TextForApiKeyImage]: [UIImage imageNamed:@"cell_salats"],
                 [Settings text:TextForApiKeyTitle]: @"Салаты",
                 },
             @{
                 [Settings text:TextForApiKeyId]: [NSNumber numberWithInteger:4],
                 [Settings text:TextForApiKeyTableState]: [NSNumber numberWithInteger:MenuCatStateNormal],
                 [Settings text:TextForApiKeyImage]: [UIImage imageNamed:@"cell_sup"],
                 [Settings text:TextForApiKeyTitle]: @"Супы",
                 },
             @{
                 [Settings text:TextForApiKeyId]: [NSNumber numberWithInteger:5],
                 [Settings text:TextForApiKeyTableState]: [NSNumber numberWithInteger:MenuCatStateYellow],
                 [Settings text:TextForApiKeyImage]: [UIImage imageNamed:@"cell_blyuda"],
                 [Settings text:TextForApiKeyTitle]: @"Основные блюда",
                 },
             @{
                 [Settings text:TextForApiKeyId]: [NSNumber numberWithInteger:6],
                 [Settings text:TextForApiKeyTableState]: [NSNumber numberWithInteger:MenuCatStateYellow],
                 [Settings text:TextForApiKeyImage]: [UIImage imageNamed:@"cell_grill"],
                 [Settings text:TextForApiKeyTitle]: @"Гриль",
                 },
             @{
                 [Settings text:TextForApiKeyId]: [NSNumber numberWithInteger:7],
                 [Settings text:TextForApiKeyTableState]: [NSNumber numberWithInteger:MenuCatStateNormal],
                 [Settings text:TextForApiKeyImage]: [UIImage imageNamed:@"cell_pasta"],
                 [Settings text:TextForApiKeyTitle]: @"Гарниры",
                 },
             @{
                 [Settings text:TextForApiKeyId]: [NSNumber numberWithInteger:8],
                 [Settings text:TextForApiKeyTableState]: [NSNumber numberWithInteger:MenuCatStateNormal],
                 [Settings text:TextForApiKeyImage]: [UIImage imageNamed:@"cell_bread"],
                 [Settings text:TextForApiKeyTitle]: @"Хлеб",
                 },
             @{
                 [Settings text:TextForApiKeyId]: [NSNumber numberWithInteger:9],
                 [Settings text:TextForApiKeyTableState]: [NSNumber numberWithInteger:MenuCatStateNormal],
                 [Settings text:TextForApiKeyImage]: [UIImage imageNamed:@"cell_sweet"],
                 [Settings text:TextForApiKeyTitle]: @"Десерт",
                 },
             @{
                 [Settings text:TextForApiKeyId]: [NSNumber numberWithInteger:10],
                 [Settings text:TextForApiKeyTableState]: [NSNumber numberWithInteger:MenuCatStateNormal],
                 [Settings text:TextForApiKeyImage]: [UIImage imageNamed:@"cell_cofe"],
                 [Settings text:TextForApiKeyTitle]: @"Напитки",
                },
             @{
                 [Settings text:TextForApiKeyId]: [NSNumber numberWithInteger:11],
                 [Settings text:TextForApiKeyTableState]: [NSNumber numberWithInteger:MenuCatStateYellow],
                 [Settings text:TextForApiKeyImage]: [UIImage imageNamed:@"cell_alco"],
                 [Settings text:TextForApiKeyTitle]: @"Алкоголь",
                 },
            ];
}


#pragma mark - Orders

+ (NSArray *)ordersFiltersItemName
{
    return @[
                @"Заказы",
                @"Дата",
                @"Столы",
                @"Официанты",
             ];
}

+ (NSArray *)ordersFiltersOrderTypeItems
{
    return @[
                @"Все",
                @"Активные",
                @"Закрытые",
             ];
}

+ (NSArray *)ordersInfoFieldsTitles
{
    return @[
                @"Официант",
                @"Стол",
             ];
}

@end
