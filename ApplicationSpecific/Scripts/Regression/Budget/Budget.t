[ ] 
[ ] 
[ ] 
[ ] 
[ ] 
[ ] 
[ ] 
[ ] 
[ ] 
[ ] // *********************************************************
[+] // FILE NAME:	<Budget.t>
	[ ] //
	[ ] // DESCRIPTION:
	[ ] //   This script contains all Budget test cases for Quicken Desktop
	[ ] //
	[ ] // DEPENDENCIES:	include.inc
	[ ] //
	[ ] // DEVELOPED BY:	  Mukesh
	[ ] //
	[ ] // Developed on: 
	[ ] //			
	[ ] // REVISION HISTORY:
	[ ] //	 March 24, 2014	Mukesh  Created
[ ] // *********************************************************
[ ] 
[ ] 
[ ] // ==========================================================
[+] // INCLUDED FILES
	[ ] use "..\..\FrameworkSpecific\FrameworkFiles\Includes.inc" 	
	[ ] 
[ ] // ==========================================================
[ ] 
[+] // Global variables 
	[ ] 
	[ ] 
	[ ] //----------STRING-------------------
	[ ] 
	[ ] STRING sAccountName ,sActualMessage ,sExpectedMessage ,sHandle ,sActual , sViewName  ,sItem  ,sRollUpState ,sAmount ,sActualAmount ,sTxnAmount
	[ ] STRING  sCategoryType ,sExpectedCategory , sParentCategory ,sCategory ,sExpectedAmount ,sOption ,sTxnExpectedAmount ,sCurrentMonth
	[ ] STRING sActualMonth ,sCurrentYear,sAmountString ,sActualGraphViewSummaryTotalLeft ,sActualSummaryTotalSpending,sActualSummaryTotalBudget
	[ ] STRING sYear ,sActualSummaryTotalSavings ,sExpectedAnnualViewSavings ,sActualSummaryTotalLeft
	[ ] STRING sExpectedAnnualViewSpending ,sExpectedAnnualViewBudget ,sExpectedAnnualViewLeft
	[ ] STRING sExpectedNoTxnRollOverAmount ,sExpectedTxnRollOverAmount ,sExpectedPattern
	[ ] INTEGER iCatCount ,iBudgetAmount,iMonthCount ,iPreviousMonth,iCurrentMonth,iTxnAmount ,iTotalRolloverAmount,iCatTotalRolloverAmount
	[ ] INTEGER iOccurrence ,iTotalSpending ,iLeftover ,iAmount
	[ ] INTEGER iYear ,iDays ,iKeyDown
	[ ] INTEGER iTxnMonthCount ,iTotalBudget ,iTxnMonths ,iNoTxnMonths ,iBillReminderAmount ,iTotalExpense,iTotalBalance ,iListCounter,iRollOverMonthCount
	[ ] INTEGER iRollOverWithNoTxnMonthAmount ,iRemainingMonthsAmount ,iRemainingMonths ,iRollOverWithNoTxnMonthCount ,iExpectedNoTxnRollOverAmount
	[ ] INTEGER iDiffOfBudgetTxnAmount ,iExpectedTxnRollOverAmount ,iBudgetMonths
	[ ] NUMBER nAmount
	[ ] 
	[ ] REAL rTotalBudget ,rBudgetAmount ,rTotalExpense ,rNetDifference ,rTxnAmount ,rAmount ,rBillReminderAmount,rBalance
	[ ] LIST OF ANYTYPE lsCategoryList , lsCategoryList2 , lsCategoryList1,lsTransaction ,lsRolloverData ,lsTxnExcelData  ,lsReminderData ,lsCategoryBudget ,lsActualData
	[ ] 
	[ ] public STRING sBudgetExcelsheet="BudgetTestData"
	[ ] public STRING sAccountWorksheet = "Account"
	[ ] public STRING sCategoriesWorksheet = "Categories"
	[ ] public STRING sBudgetedCategoriesWorksheet = "BudgetedCategories"
	[ ] public STRING sRegTransactionSheet = "RegCheckingTransaction"
	[ ] public STRING sBillWorksheet="Bill"
	[ ] 
	[ ] public STRING sBudgetFileName="budgetedataFile"
	[ ] 
	[ ] public STRING sDateFormat="m/d/yyyy"
	[ ] public STRING sDate=ModifyDate(0,sDateFormat)
	[ ] 
	[ ] public STRING sMDIWindow="MDI"
	[ ] 
	[ ] public STRING  sbudgetedataFile = AUT_DATAFILE_PATH + "\" + sBudgetFileName + ".QDF"
	[ ] 
	[ ] STRING  sbudgetedataFileSource = AUT_DATAFILE_PATH + "\DataFile\" + sBudgetFileName + ".QDF"
	[ ] LIST OF ANYTYPE lsBudgetViews = {"Graph View" , "Annual View"}
	[ ] public STRING sGraphView ="Graph View"
	[ ] public STRING sAnnualView ="Annual View"
	[ ] STRING sBudgetName = "BudgetTest"
	[ ] 
	[ ] 
	[ ] 
	[ ] STRING sGetStarted ="Get Started"
	[ ] public STRING sEverythingElse="Everything Else"
	[ ] public STRING sRootEverythingElse="Root Everything Else"
	[ ] 
	[ ] public STRING sOther="Other"
	[ ] 
	[ ] STRING sCustomCatGroup= "CUSTOMCAT"
	[ ] STRING sTransactionsTab = "Transactions"
	[ ] STRING sIncomeCategoryGroup = "Income"
	[ ] STRING sExpensesCategoryGroup = "Expenses"
	[ ] STRING sSetRollOverOff = "Turn rollover off"
	[ ] STRING sSetRollOverBalance = "Rollover balances at the end of each month"
	[ ] STRING sSetPositiveRollOverBalance = "Rollover only positive balances at the end of each month"
	[ ] STRING sRollOverHelp = "Rollover help"
	[ ] STRING sUndoAllRolloverEdits ="Undo all rollover edits"
	[ ] ///Gear options
	[ ] STRING sApplyBudgetForward = "Apply Budget Forward"
	[ ] STRING sApplyBudgetForAll = "Apply Budget For All"
	[ ] STRING sEditYearlyBudget ="Edit Yearly Budget"
	[ ] STRING sCalculateAverageBudget = "Calculate Average Budget"
	[ ] STRING sSetAverageBudgetBasedOnThisCategory = "Set Average Budget Based On This Category"
	[ ] STRING sHelp = "Help"
	[ ] STRING sIncomeCategoryType ,sIncomeCategory
	[ ] 
	[ ] //------------------INTEGER----------------
	[ ] public INTEGER iResult , iCount ,iCounter ,iListCount
	[ ] 
	[ ] //--------------BOOLEAN---------------
	[ ] public BOOLEAN bMatch ,bResult
	[ ] 
	[ ] //--------------Lists---------------
	[ ] LIST OF ANYTYPE lsExcelData ,lsAddAccount
	[ ] 
	[ ] public POINT pPoint
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[+] public INTEGER SelectOneCategoryToBudget(STRING sCategoryType , STRING sCategory)
	[ ] INTEGER iFunctionResult
	[+] do
		[ ] QuickenWindow.SetActive()
		[ ] MDIClient.Budget.SelectCategoryToBudgetLink.Click()
		[+] if (SelectCategoriesToBudget.Exists(4))
			[ ] SelectCategoriesToBudget.SetActive()
			[ ] SelectCategoriesToBudget.TextClick(sCategoryType)
			[ ] sHandle= Str(SelectCategoriesToBudget.ListBox.GetHandle())
			[ ] iListCount= SelectCategoriesToBudget.ListBox.GetItemCount() 
			[+] for(iCount= 0; iCount <= iListCount;  iCount++)
				[+] if (iCount>0)
					[ ] SelectCategoriesToBudget.ListBox.VScrollBar.ScrollByLine(1)
					[ ] 
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
				[ ] bMatch = MatchStr("*{trim(sCategory)}*", sActual)
				[+] if (bMatch)
					[+] if (SelectCategoriesToBudget.ListBox.VScrollBar.Exists())
						[ ] SelectCategoriesToBudget.ListBox.VScrollBar.ScrollByLine(-2)
					[ ] sleep(1)
					[ ] SelectCategoriesToBudget.TextClick(sCategory)
					[+] if (SelectCategoriesToBudget.ListBox.VScrollBar.Exists())
						[ ] SelectCategoriesToBudget.ListBox.VScrollBar.ScrollToMin()
					[ ] break
				[ ] 
			[+] if (bMatch)
				[ ] iFunctionResult = PASS
			[+] else
				[ ] ReportStatus("Verify Category found in the Select Categories To Budget dialog.", FAIL, "Category couldn't be found in the Select Categories To Budget dialog.")
				[ ] iFunctionResult = FAIL
			[ ] 
			[ ] SelectCategoriesToBudget.OK.Click()
			[ ] WaitForState(SelectCategoriesToBudget , False ,3)
		[+] else
			[ ]  ReportStatus("Verify Select Categories to Budget dialog appeared. ", FAIL , "Select Categories to Budget dialog didn't appear.") 
			[ ] iFunctionResult=FAIL
		[ ] 
	[+] except
		[ ] iFunctionResult=FAIL
		[ ] Exceptlog()
	[ ] return iFunctionResult
[ ] 
[+] public INTEGER RemoveCategoryFromBudget(STRING sCategory)
	[ ] INTEGER iFunctionResult
	[ ] STRING sRemoveCategoryOption
	[ ] sRemoveCategoryOption="Remove this category"
	[+] do
		[ ] QuickenWindow.SetActive()
		[ ] SelectRightClickCategoryOptions(sCategory, sRemoveCategoryOption)
		[+] if (DlgRemoveCategory.Exists(2))
			[ ] DlgRemoveCategory.SetActive()
			[ ] DlgRemoveCategory.RemoveButton.Click()
			[ ] WaitForState(DlgRemoveCategory , False ,5)
			[ ] iFunctionResult=PASS
			[ ] 
		[+] else
			[ ] iFunctionResult=FAIL
	[+] except
		[ ] iFunctionResult=FAIL
		[ ] Exceptlog()
	[ ] return iFunctionResult
[ ] 
[ ] 
[+] public INTEGER VerifyCategoryHierarchyOnBudgetOnGraphView (STRING sCategoryType , STRING sParentCategory ,  LIST OF ANYTYPE lsCategoryList , BOOLEAN bOnlyChildCategoriesbudgeted)
	[+] //--------------Variable Declaration-------------
		[ ] INTEGER iFunctionResult
		[ ] iCatCount=1
	[ ] 
	[+] do
		[ ] QuickenWindow.SetActive()
		[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sGraphView)
		[ ] sleep(3)
		[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
		[ ] iListCount= MDIClient.Budget.ListBox.GetItemCount() +1
		[+] switch (bOnlyChildCategoriesbudgeted)
			[ ] 
			[+] case FALSE
				[+] for(iCount= 0; iCount <= iListCount;  iCount++)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
					[ ] bMatch = MatchStr("*{sCategoryType}*", sActual)
					[+] if (bMatch)
						[ ] iCounter = iCount +1
						[+] for(iCount= iCounter; iCount <= iListCount;  iCount++)
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
							[ ] bMatch = MatchStr("*{sParentCategory}*", sActual)
							[+] if (bMatch)
								[ ] 
								[ ] iCounter = iCount +1
								[+] for (iCount= iCounter; iCount < iCounter + ListCount(lsCategoryList);  iCount++)
									[ ] 
									[ ] //// iCatCount is used to iterate the category list
									[+] if (lsCategoryList[iCatCount]==NULL)
										[ ] break
									[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
									[ ] bMatch = MatchStr("*{lsCategoryList[iCatCount]}*", sActual)
									[+] if (bMatch)
										[ ]  ReportStatus("Verify category hierarchical display when parent rollup is ON on Graph View. ", PASS , " Category:{lsCategoryList[iCatCount]} displayed as expected:{sActual} with parent: {sParentCategory} under Category Type:{sCategoryType} on Graph View.") 
										[ ] iFunctionResult=PASS
									[+] else
										[ ]  ReportStatus("Verify category hierarchical display when parent rollup is ON on Graph View.", FAIL , " Category:{lsCategoryList[iCatCount]} didn't display as expected: with parent: {sParentCategory} under Category Type:{sCategoryType}, actual category is: {sActual} on Graph View.") 
										[ ] iFunctionResult=FAIL
									[ ] iCatCount++
								[ ] 
								[ ] break
						[+] if (bMatch==False)
							[ ] ReportStatus("Verify Parent Category found on budget graph view." , FAIL , "Parent Category: {sParentCategory} couldn't be found on budget graph view.")
							[ ] iFunctionResult=FAIL
						[ ] break
						[ ] 
					[+] else
						[ ] continue
					[ ] 
				[+] if (bMatch==False)
					[ ] ReportStatus("Verify Category type found on budget graph view." , FAIL , "Category type: {sCategoryType} couldn't be found on budget graph view.")
					[ ] iFunctionResult=FAIL
				[ ] 
				[ ] 
			[+] case TRUE
				[+] for(iCount= 0; iCount <= iListCount;  iCount++)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
					[ ] bMatch = MatchStr("*{sCategoryType}*", sActual)
					[+] if (bMatch)
						[ ] iCounter = iCount +1
						[+] for (iCount= iCounter; iCount < iCounter+ListCount(lsCategoryList);  iCount++)
							[ ] 
							[ ] //// iCatCount is used to iterate the category list
							[+] if (lsCategoryList[iCatCount]==NULL)
								[ ] break
							[ ] 
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
							[ ] 
							[ ] sExpectedCategory="{sParentCategory}:*{lsCategoryList[iCatCount]}"
							[ ] bMatch = MatchStr("*{sExpectedCategory}*", sActual)
							[+] if (bMatch)
								[ ] break
						[+] if (bMatch)
							[ ]  ReportStatus("Verify category hierarchical display when parent rollup is OFF on Graph View.", PASS , " Category:{lsCategoryList[iCatCount]} displayed as expected:{sActual} with parent: {sParentCategory} under Category Type:{sCategoryType} on Graph View.") 
							[ ] iFunctionResult=PASS
						[+] else
							[ ]  ReportStatus("Verify category hierarchical display when parent rollup is OFF on Graph View.", FAIL , " Category:{lsCategoryList[iCatCount]} didn't display as expected:{sExpectedCategory} with parent: {sParentCategory} under Category Type:{sCategoryType}, actual category is: {sActual} on Graph View.") 
							[ ] iFunctionResult=FAIL
							[ ] 
							[ ] iCatCount++
						[ ] break
				[+] if (bMatch==False)
					[ ] ReportStatus("Verify Category type found on budget graph view." , FAIL , "Category type: {sCategoryType} couldn't be found on budget graph view.")
					[ ] iFunctionResult=FAIL
				[ ] 
			[ ] 
	[+] except
		[ ] ExceptLog()
		[ ] iFunctionResult=FAIL
		[ ] 
	[ ] return iFunctionResult
	[ ] 
[ ] 
[+] public INTEGER VerifyCategoryHierarchyOnBudgetOnAnnualView (STRING sCategoryType , STRING sParentCategory ,  LIST OF ANYTYPE lsCategoryList , BOOLEAN bOnlyChildCategoriesbudgeted)
	[+] //--------------Variable Declaration-------------
		[ ] INTEGER iFunctionResult
		[ ] iCatCount=1
	[ ] 
	[+] do
		[ ] QuickenWindow.SetActive()
		[ ] // Select Annual View on Budget
		[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sAnnualView)
		[ ] sleep(3)
		[ ] QuickenWindow.SetActive()
		[ ] 
		[+] switch (bOnlyChildCategoriesbudgeted)
			[ ] 
			[+] case FALSE
				[+] do
					[ ] MDIClient.Budget.ListBox.TextClick(Upper(sCategoryType))
					[ ]  ReportStatus("Verify that Category Type  displayed as expected on Annual View." , PASS, "Category Type: {sCategoryType} displayed as expected on Annual View.")
					[ ] 
					[ ] //Verify that Parent Category is hidden when category type is collapsed
					[+] do
						[ ] MDIClient.Budget.ListBox.TextClick(sParentCategory)
						[ ]  ReportStatus("Verify that Parent Category is hidden when category type is collapsed" , FAIL, "Parent Category: {sParentCategory} didn't hide under the Category Type: {sCategoryType} on Annual View.")
						[ ] iFunctionResult=FAIL
					[+] except
						[ ]  ReportStatus("Verify that Parent Category  is hidden when category type is collapsed" , PASS, "Parent Category: {sParentCategory} is hidden under the Category Type: {sCategoryType} on Annual View.")
						[ ] 
						[ ] //Expand category type
						[ ] MDIClient.Budget.ListBox.TextClick(Upper(sCategoryType))
						[ ] 
						[+] do
							[ ] MDIClient.Budget.ListBox.TextClick(sParentCategory)
							[ ] ReportStatus("Verify that Parent Category displayed on Annual View." , PASS, "Parent Category: {sParentCategory} displayed under the Category Type: {sCategoryType} on Annual View.")
							[+] for each sCategory in lsCategoryList
								[+] do
									[+] if (sCategory==NULL)
										[ ] break
									[ ] MDIClient.Budget.ListBox.TextClick(sCategory)
									[ ]  ReportStatus("Verify that Sub Category is displayed on Annual View." , PASS, "Sub Category: {sCategory} displayed on Annual View.")
									[ ] iFunctionResult=PASS
								[+] except
									[ ]  ReportStatus("Verify that Sub Category is displayed on Annual View." , FAIL, "Sub Category: {sCategory} didn't display on Annual View.")
									[ ] iFunctionResult=FAIL
							[ ] 
						[+] except
							[ ] ReportStatus("Verify that Parent Category displayed as expected on Annual View." , FAIL, "Parent Category: {sParentCategory} didn't display as expected under under the Category Type: {sCategoryType} on Annual View.")
							[ ] iFunctionResult=FAIL
					[ ] 
				[+] except
					[ ]   ReportStatus("Verify that Category Type  displayed on Annual View" , FAIL, "Category Type: {sCategoryType} didn't display on annual View")
					[ ] iFunctionResult=FAIL
				[ ] 
				[ ] 
			[+] case TRUE
				[+] do
					[ ] MDIClient.Budget.ListBox.TextClick(Upper(sCategoryType))
					[ ]  ReportStatus("Verify that Category Type  displayed as expected on Annual View." , PASS, "Category Type: {sCategoryType} displayed as expected on Annual View.")
					[ ] 
					[ ] //Verify that Parent Category is hidden when category type is collapsed
					[+] do
						[ ] MDIClient.Budget.ListBox.TextClick(sParentCategory)
						[ ]  ReportStatus("Verify that Parent Category is hidden when category type is collapsed" , FAIL, "Parent Category: {sParentCategory} didn't hide under the Category Type: {sCategoryType} on Annual View.")
						[ ] iFunctionResult=FAIL
					[+] except
						[ ] ReportStatus("Verify that Parent Category displayed on Annual View." , PASS, "Parent Category: {sParentCategory} displayed under the Category Type: {sCategoryType} on Annual View.")
						[ ] MDIClient.Budget.ListBox.TextClick(Upper(sCategoryType))
						[+] for each sCategory in lsCategoryList
							[+] do
								[+] if (sCategory==NULL)
									[ ] break
								[ ] sExpectedCategory="{sParentCategory}: {sCategory}"
								[+] MDIClient.Budget.ListBox.TextClick(sExpectedCategory)
									[ ]  ReportStatus("Verify that Sub Category is displayed on Annual View." , PASS, "Sub Category: {sExpectedCategory} displayed on Annual View.")
								[ ] iFunctionResult=PASS
							[+] except
									[ ]  ReportStatus("Verify that Sub Category is displayed on Annual View." , FAIL, "Sub Category: {sExpectedCategory} didn't display on Annual View.")
								[ ] iFunctionResult=FAIL
						[ ] 
					[ ] 
				[+] except
					[ ]   ReportStatus("Verify that Category Type  displayed as expected on Annual View." , FAIL, "Category Type: {sCategoryType} didn't display on Annual View.")
					[ ] iFunctionResult=FAIL
				[ ] 
				[ ] 
			[ ] 
	[+] except
		[ ] ExceptLog()
		[ ] iFunctionResult=FAIL
		[ ] 
	[ ] return iFunctionResult
	[ ] 
[ ] 
[+] public INTEGER VerifyParentCategoryHierarchyOnBudgetOnAnnualAndGraphView(STRING sCategoryType , STRING sParentCategory , BOOLEAN bGraphView)
	[+] do
		[+] switch (bGraphView)
			[+] case TRUE
				[ ] QuickenWindow.SetActive()
				[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sGraphView)
				[ ] sleep(3)
				[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
				[ ] iListCount= MDIClient.Budget.ListBox.GetItemCount() +1
				[ ] 
				[ ] 
				[+] for(iCount= 0; iCount <= iListCount;  iCount++)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
					[ ] bMatch = MatchStr("*{sCategoryType}*", sActual)
					[+] if (bMatch)
						[ ] iCounter = iCount +1
						[+] for (iCount= iCounter; iCount < iListCount ;  iCount++)
							[ ] 
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
							[ ] 
							[ ] bMatch = MatchStr("*{sParentCategory}*", sActual)
							[+] if (bMatch)
								[ ] break
						[+] if (bMatch)
							[ ]  ReportStatus("Verify category hierarchical display when parent rollup is ON on Graph View.", PASS , " Category:{sParentCategory} displayed as expected:{sActual} under Category Type:{sCategoryType} on Graph View.") 
							[ ] iFunctionResult=PASS
						[+] else
							[ ]  ReportStatus("Verify category hierarchical display when parent rollup is ON on Graph View.", FAIL , " Category:{sParentCategory} didn't display as expected under Category Type:{sCategoryType}, actual category is: {sActual} on Graph View.") 
							[ ] iFunctionResult=FAIL
							[ ] 
						[ ] break
				[+] if (bMatch==False)
					[ ] ReportStatus("Verify Category type found on budget graph view." , FAIL , "Category type: {sCategoryType} couldn't be found on budget graph view.")
					[ ] iFunctionResult=FAIL
				[ ] 
			[+] case FALSE
					[ ] QuickenWindow.SetActive()
					[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sAnnualView)
					[ ] sleep(3)
					[ ] 
					[ ] MDIClient.Budget.ListBox.TextClick(Upper(sCategoryType))
					[ ]  ReportStatus("Verify that Category Type  displayed as expected on Annual View." , PASS, "Category Type: {sCategoryType} displayed as expected on Annual View.")
					[ ] 
					[ ] //Verify that Parent Category is hidden when category type is collapsed
					[+] do
						[ ] MDIClient.Budget.ListBox.TextClick(sParentCategory)
						[ ]  ReportStatus("Verify that Parent Category is hidden when category type is collapsed" , FAIL, "Parent Category: {sParentCategory} didn't hide under the Category Type: {sCategoryType} on Annual View.")
						[ ] iFunctionResult=FAIL
					[+] except
						[ ]  ReportStatus("Verify that Parent Category  is hidden when category type is collapsed" , PASS, "Parent Category: {sParentCategory} is hidden under the Category Type: {sCategoryType} on Annual View.")
						[ ] 
						[ ] //Expand category type
						[ ] MDIClient.Budget.ListBox.TextClick(Upper(sCategoryType))
						[ ] 
						[+] do
							[ ] MDIClient.Budget.ListBox.TextClick(sParentCategory)
							[ ] ReportStatus("Verify that Parent Category displayed on Annual View." , PASS, "Parent Category: {sParentCategory} displayed under the Category Type: {sCategoryType} on Annual View.")
							[ ] 
						[+] except
							[ ] ReportStatus("Verify that Parent Category displayed as expected on Annual View." , FAIL, "Parent Category: {sParentCategory} didn't display as expected under under the Category Type: {sCategoryType} on Annual View.")
							[ ] iFunctionResult=FAIL
					[ ] 
	[+] except
		[ ]   ReportStatus("Verify that Category Type  displayed on Annual View" , FAIL, "Category Type: {sCategoryType} didn't display on annual View")
		[ ] iFunctionResult=FAIL
	[ ] return iFunctionResult
	[ ] // 
[ ] 
[ ] 
[+] public INTEGER SelectDeselectGearMenuOptions( STRING sCategory, STRING sOption, BOOLEAN bView optional)
	[ ] INTEGER iFunctionResult
	[+] if (bView==NULL)
		[ ] bView=TRUE
	[ ] 
	[+] do
		[+] switch (bView)
			[+] case TRUE
				[ ] QuickenWindow.SetActive()
				[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sGraphView)
				[ ] 
				[ ] MDIClient.Budget.ListBox.TextClick(sCategory)
				[ ] MDIClient.Budget.ListBox.Amount.Click()
				[ ] pPoint=Cursor.GetPosition()
				[ ] 
				[ ] sleep(1)
				[ ] QuickenWindow.Click(1, pPoint.x-33 ,pPoint.y+5)
				[ ] sleep(1)
			[+] case FALSE
				[ ] QuickenWindow.SetActive()
				[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sAnnualView)
				[ ] 
				[ ] MDIClient.Budget.ListBox.TextClick(sCategory)
				[ ] MDIClient.Budget.ListBox.Amount.Click()
				[ ] pPoint=Cursor.GetPosition()
				[ ] 
				[ ] sleep(1)
				[ ] QuickenWindow.Click(1, pPoint.x-60 ,pPoint.y+5)
				[ ] sleep(1)
			[ ] 
		[ ] 
		[+] switch (sOption)
			[+] case  sApplyBudgetForward 
				[ ] iCount=1
			[+] case  sApplyBudgetForAll 
				[ ] iCount=2
			[+] case  sEditYearlyBudget 
				[ ] iCount=3
			[+] case  sCalculateAverageBudget 
				[ ] iCount=4
			[+] case sSetAverageBudgetBasedOnThisCategory
				[ ] iCount=5
			[+] case sHelp
				[ ] iCount=6
		[ ] MDIClient.Budget.ListBox.TypeKeys(replicate(KEY_DN, iCount))
		[ ] MDIClient.Budget.ListBox.TypeKeys(KEY_ENTER)
		[ ] iFunctionResult=PASS
	[+] except
		[ ] iFunctionResult=FAIL
		[ ] Exceptlog()
	[ ] return iFunctionResult
[ ] 
[+] public INTEGER  SelectDeselectRollOverOptions ( STRING sCategory, STRING sOption ,  BOOLEAN bView optional)
	[ ] INTEGER iFunctionResult
	[ ] POINT pPoint
	[+] if (bView==NULL)
		[ ] bView=TRUE
	[+] do
		[ ] QuickenWindow.SetActive()
		[+] switch (bView)
			[+] case TRUE
				[ ] 
				[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sGraphView)
				[ ] sleep(3)
				[ ] MDIClient.Budget.ListBox.TextClick(sCategory)
				[ ] MDIClient.Budget.ListBox.Amount.Click()
				[ ] pPoint=Cursor.GetPosition()
				[ ] 
				[ ] sleep(1)
				[ ] QuickenWindow.Click(1, pPoint.x-60 ,pPoint.y+5)
				[ ] sleep(1)
				[ ] 
			[+] case FALSE
				[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sAnnualView)
				[ ] sleep(3)
				[ ] MDIClient.Budget.AnnualViewTypeComboBox.Select("Budget only")
				[ ] 
				[ ] // MDIClient.Budget.AnnualViewTypeComboBox.Select("Details")
				[ ] MDIClient.Budget.ListBox.TextClick(sCategory)
				[ ] MDIClient.Budget.ListBox.Amount.Click()
				[ ] pPoint=Cursor.GetPosition()
				[ ] 
				[ ] sleep(1)
				[ ] QuickenWindow.Click(1, pPoint.x-36 ,pPoint.y+5)
				[ ] sleep(1)
		[ ] 
		[ ] 
		[+] switch (sOption)
			[+] case sSetRollOverOff
				[ ] iCount=1
			[+] case sSetRollOverBalance
				[ ] iCount=2
			[+] case sSetPositiveRollOverBalance
				[ ] iCount=3
			[+] case sRollOverHelp
				[ ] iCount=4
			[ ] //this menu option appears only when rollover is reset
			[+] case sUndoAllRolloverEdits
				[ ] iCount=4
			[ ] 
		[ ] MDIClient.Budget.ListBox.TypeKeys(replicate(KEY_DN, iCount))
		[ ] MDIClient.Budget.ListBox.TypeKeys(KEY_ENTER)
		[ ] iFunctionResult=PASS
	[+] except
		[ ] iFunctionResult=FAIL
		[ ] Exceptlog()
	[ ] return iFunctionResult
[ ] 
[+] public INTEGER SelectDeselectGearMenuOptionsAnnualView( STRING sCategory, STRING sOption)
	[ ] INTEGER iFunctionResult
	[ ] POINT pPoint
	[+] do
		[ ] QuickenWindow.SetActive()
		[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sAnnualView)
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] MDIClient.Budget.ListBox.TextClick(sCategory)
		[ ] pPoint=Cursor.GetPosition()
		[ ] 
		[ ] sleep(1)
		[ ] QuickenWindow.Click(1, pPoint.x+155 ,pPoint.y+5)
		[ ] 
		[+] switch (sOption)
			[+] case  sApplyBudgetForward 
				[ ] iCount=1
			[+] case  sApplyBudgetForAll 
				[ ] iCount=2
			[+] case  sEditYearlyBudget 
				[ ] iCount=3
			[+] case  sCalculateAverageBudget 
				[ ] iCount=4
			[+] case "Set Average Budget Based On This Category"
				[ ] iCount=5
			[+] case "Help"
				[ ] iCount=6
		[ ] MDIClient.Budget.ListBox.TypeKeys(replicate(KEY_DN, iCount))
		[ ] MDIClient.Budget.ListBox.TypeKeys(KEY_ENTER)
		[ ] iFunctionResult=PASS
	[+] except
		[ ] iFunctionResult=FAIL
		[ ] Exceptlog()
	[ ] return iFunctionResult
[ ] 
[+] public INTEGER SelectRightClickCategoryOptions( STRING sCategory, STRING sOption)
	[ ] INTEGER iFunctionResult
	[ ] POINT pPoint
	[+] do
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] MDIClient.Budget.ListBox.TextClick(sCategory,NULL, CT_RIGHT)
		[ ] // pPoint=Cursor.GetPosition()
		[ ] // sleep(1)
		[ ] // QuickenWindow.Click(2, pPoint.x,pPoint.y)
		[ ] 
		[+] switch (sOption)
			[+] case "Remove this category"
				[ ] iCount=1
			[+] case  sEditYearlyBudget 
				[ ] iCount=2
			[+] case  sCalculateAverageBudget 
				[ ] iCount=3
				[+] if (sCategory==sEverythingElse)
					[ ] iCount=2
				[ ] 
			[+] case "Choose categories"
				[ ] iCount=4
			[+] default
				[ ] iFunctionResult=FAIL
		[ ] MDIClient.Budget.ListBox.TypeKeys(replicate(KEY_DN, iCount))
		[ ] MDIClient.Budget.ListBox.TypeKeys(KEY_ENTER)
		[ ] iFunctionResult=PASS
	[+] except
		[ ] iFunctionResult=FAIL
		[ ] Exceptlog()
	[ ] return iFunctionResult
	[ ] 
[ ] 
[+] ClearTheBudgetValuesOnAnnualView( STRING sCategory)
	[+] do
		[ ] ///Clear the budget values
		[ ] QuickenWindow.SetActive()
		[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sAnnualView)
		[ ] MDIClient.Budget.ListBox.TextClick(sCategory)
		[+] for (iCount=1; iCount<=12 ; iCount++)
			[ ]  MDIClient.Budget.ListBox.Amount.SetFocus()
			[ ]  MDIClient.Budget.ListBox.Amount.SetText("0")
			[ ]  MDIClient.Budget.ListBox.TypeKeys(KEY_TAB)
			[ ] 
			[ ] 
	[+] except
		[ ] Exceptlog()
[ ] 
[+] public VOID Verify12MonthsBudgetValuesOnGraphViewAndAnnualView( STRING sCategory,INTEGER iBudgetAmount , STRING sOption)
	[+] //Variable decalaration
		[ ] STRING sMonth,sCurrentMonth,sCurrentYear,sActualMonth,sExpectedMonth,sExpectedCurrentMonth,sActualAmount
		[ ] INTEGER  iMonth ,iMonthDifference, iBackTraversal ,iForwardTraversal
		[ ] iForwardTraversal=11
		[ ] sCurrentMonth=FormatDateTime(GetDateTime(), "mmmm") //Get current month as January 2014
		[ ] sCurrentYear=FormatDateTime(GetDateTime(),"yyyy")
		[ ] sExpectedCurrentMonth=sCurrentMonth+" "+sCurrentYear
		[ ] 
	[ ] 
	[+] do
		[ ] //Edit 12 months budget
		[+] if(DlgEditYearlyBudget.Exists(5))
			[ ] DlgEditYearlyBudget.SetActive()
			[ ] DlgEditYearlyBudget.JanTextField.SetText(Str(iBudgetAmount))
			[ ] DlgEditYearlyBudget.FebTextField.SetText(Str(iBudgetAmount+1))
			[ ] DlgEditYearlyBudget.MarTextField.SetText(Str(iBudgetAmount+2))
			[ ] DlgEditYearlyBudget.AprTextField.SetText(Str(iBudgetAmount+3))
			[ ] DlgEditYearlyBudget.MayTextField.SetText(Str(iBudgetAmount+4))
			[ ] DlgEditYearlyBudget.JunTextField.SetText(Str(iBudgetAmount+5))
			[ ] DlgEditYearlyBudget.JulTextField.SetText(Str(iBudgetAmount+6))
			[ ] DlgEditYearlyBudget.AugTextField.SetText(Str(iBudgetAmount+7))
			[ ] DlgEditYearlyBudget.SeptTextField.SetText(Str(iBudgetAmount+8))
			[ ] DlgEditYearlyBudget.OctTextField.SetText(Str(iBudgetAmount+9))
			[ ] DlgEditYearlyBudget.NovTextField.SetText(Str(iBudgetAmount+10))
			[ ] DlgEditYearlyBudget.DecTextField.SetText(Str(iBudgetAmount+11))
			[ ] 
			[ ] 
			[ ] DlgEditYearlyBudget.OKButton.Click()
			[ ] WaitForState(DlgEditYearlyBudget , False , 5)
			[ ] 
			[ ] ReportStatus("Verify that User is able to edit 12 months budget using {sOption} on category." , PASS,"Budget for 12 months has been edited via the {sOption} on category on Graph View.")
			[ ] 
			[ ] 
			[ ] //Verify Budget amount for each month
			[ ] //Go to Jan to start verification
			[ ] QuickenWindow.SetActive()
			[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sGraphView)
			[ ] sleep(4)
			[ ] QuickenWindow.SetActive()
			[ ] sActualMonth=MDIClient.Budget.CurrentMonthStaticText.GetText()
			[+] while (sActualMonth!=lsListOfMonths[1]+" "+sCurrentYear)
				[ ] MDIClient.Budget.BackWardMonthButton.Click()
				[ ] sActualMonth=MDIClient.Budget.CurrentMonthStaticText.GetText()
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] //Verify Budget amount for each month on Graph View
			[ ] QuickenWindow.SetActive()
			[ ] sActualMonth=MDIClient.Budget.CurrentMonthStaticText.GetText()
			[+] for (iCounter=1 ; iCounter<=iForwardTraversal+1;++iCounter)
				[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
				[ ] iListCount= MDIClient.Budget.ListBox.GetItemCount() +1
				[ ] ///Starting count with first subcategory as we know which category we are editing 
				[+] for (iCount=3 ; iCount<=iListCount;++iCount)
					[ ] 
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
					[ ] bMatch = MatchStr("*{sCategory}*{iBudgetAmount+iCounter-1}*", sActual)
					[+] if (bMatch)
						[ ] break
				[+] if(bMatch)
					[ ] ReportStatus("Verify that User should be able to edit all 12 months of the currently selected budget from a single dialog using {sOption} for category." ,PASS, "The budget for month:{lsListOfMonths[iCounter]} has been updated:{sActual} as expected:{iBudgetAmount+iCounter-1} using {sOption} for category: {sCategory} on Graph view.")
				[+] else
					[ ] ReportStatus("Verify that User should be able to edit all 12 months of the currently selected budget from a single dialog using {sOption} for category." ,FAIL, "The budget for month:{lsListOfMonths[iCounter]} couldn't be updated:{sActual} as expected:{iBudgetAmount+iCounter-1} using {sOption} for category: {sCategory} on Graph view.")
				[ ] 
				[+] if(iCounter<12)
					[ ] MDIClient.Budget.ForwardMonthButton.Click()
				[+] else
					[ ] break
			[ ] 
			[ ] //Go to Current month to start verification
			[ ] QuickenWindow.SetActive()
			[ ] sActualMonth=MDIClient.Budget.CurrentMonthStaticText.GetText()
			[+] while (sActualMonth!=sExpectedCurrentMonth)
				[ ] MDIClient.Budget.BackWardMonthButton.Click()
				[ ] sActualMonth=MDIClient.Budget.CurrentMonthStaticText.GetText()
			[ ] 
			[ ] ////Verify 12 Months budget on Annual view
			[ ] ////Select Annual View of budget
			[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sAnnualView)
			[ ] sleep(2)
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
			[ ] iListCount= MDIClient.Budget.ListBox.GetItemCount() +1
			[ ] 
			[ ] ///Create the expected budget amounts
			[ ] sExpectedAmount="*{iBudgetAmount}*"
			[+] for (iCount=1 ; iCount<=11;++iCount)
				[ ] sExpectedAmount=sExpectedAmount+"*{iBudgetAmount+iCount}*"
			[ ] ///Verify on annual view
			[+] for (iCount=3 ; iCount<=iListCount;++iCount)
				[ ] 
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
				[ ] bMatch = MatchStr(sExpectedAmount, sActual)
				[+] if (bMatch)
					[ ] break
			[+] if(bMatch)
				[ ] ReportStatus("Verify that User should be able to edit all 12 months of the currently selected budget from a single dialog using {sOption} on category." ,PASS, "The budget for 12 months:has been updated:{sActual} as expected:{sExpectedAmount} using {sOption} for category: {sCategory} on Annual View.")
			[+] else
				[ ] ReportStatus("Verify that User should be able to edit all 12 months of the currently selected budget from a single dialog using {sOption} on category." ,FAIL, "The budget for 12 months couldn't be updated actualt: {sActual} as expected:{sExpectedAmount} using {sOption} for category: {sCategory} on Annual View.")
			[ ] 
			[ ] 
			[ ] ///Clear the budget values
			[ ] // ClearTheBudgetValuesOnAnnualView(sCategory)
		[+] else
			[ ] ReportStatus("Verify that User is able to edit 12 months budget using {sOption} on category."  , FAIL,"Edit Yearly Budget didn't appear using {sOption} on category on Graph View.")
	[+] except
		[ ] ExceptLog()
	[ ] 
	[ ] 
[ ] 
[+] public VOID VerifyAverageBudgetValueOnGraphViewAndAnnualView( STRING sCategory,INTEGER iBudgetAmount , STRING sOption)
	[+] //Variable decalaration
		[ ] STRING sMonth,sCurrentMonth,sCurrentYear,sActualMonth,sExpectedMonth,sExpectedCurrentMonth,sActualAmount
		[ ] INTEGER  iMonth ,iMonthDifference, iBackTraversal ,iForwardTraversal
		[ ] iForwardTraversal=11
		[ ] sCurrentMonth=FormatDateTime(GetDateTime(), "mmmm") //Get current month as January 2014
		[ ] sCurrentYear=FormatDateTime(GetDateTime(),"yyyy")
		[ ] sExpectedCurrentMonth=sCurrentMonth+" "+sCurrentYear
		[ ] 
	[ ] 
	[+] do
		[ ] //Edit 12 months budget
		[+] if(DlgCalculateAverageBudget.Exists(5))
			[ ] DlgCalculateAverageBudget.SetActive()
			[ ] DlgCalculateAverageBudget.BudgetTextField.SetText(Str(iBudgetAmount))
			[ ] DlgCalculateAverageBudget.ApplyComboBox.Select("to all of 201*")
			[ ] 
			[ ] DlgCalculateAverageBudget.OKButton.Click()
			[ ] WaitForState(DlgCalculateAverageBudget , False , 5)
			[ ] 
			[ ] ReportStatus("Verify that User is able to launch the calculate average budget using {sOption} on category." , PASS,"Budget for 12 months has been edited via the {sOption} on category on Graph View.")
			[ ] 
			[ ] 
			[ ] //Verify Average Budget amount for each month
			[ ] //Go to Jan to start verification
			[ ] QuickenWindow.SetActive()
			[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sGraphView)
			[ ] sleep(4)
			[ ] QuickenWindow.SetActive()
			[ ] sActualMonth=MDIClient.Budget.CurrentMonthStaticText.GetText()
			[+] while (sActualMonth!=lsListOfMonths[1]+" "+sCurrentYear)
				[ ] MDIClient.Budget.BackWardMonthButton.Click()
				[ ] sActualMonth=MDIClient.Budget.CurrentMonthStaticText.GetText()
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] //Verify Average Budget amount for each month on Graph View
			[ ] QuickenWindow.SetActive()
			[ ] sActualMonth=MDIClient.Budget.CurrentMonthStaticText.GetText()
			[+] for (iCounter=1 ; iCounter<=iForwardTraversal+1;++iCounter)
				[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
				[ ] iListCount= MDIClient.Budget.ListBox.GetItemCount() +1
				[ ] ///Starting count with first subcategory as we know which category we are editing 
				[+] for (iCount=3 ; iCount<=iListCount;++iCount)
					[ ] 
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
					[ ] bMatch = MatchStr("*{sCategory}*{iBudgetAmount}*", sActual)
					[+] if (bMatch)
						[ ] 
						[ ] break
				[+] if(bMatch)
					[ ] ReportStatus("Verify that User is able to update average budget using {sOption} on Graph View." ,PASS, "The average budget for month:{lsListOfMonths[iCounter]} has been updated:{sActual} as expected:{iBudgetAmount} using {sOption} for category: {sCategory} on Graph view.")
				[+] else
					[ ] ReportStatus("Verify that User is able to update average budget using {sOption} on Graph View." ,FAIL, "The average budget for month:{lsListOfMonths[iCounter]} couldn't be updated:{sActual} as expected:{iBudgetAmount} using {sOption} for category: {sCategory} on Graph view.")
				[ ] 
				[+] if(iCounter<12)
					[ ] MDIClient.Budget.ForwardMonthButton.Click()
				[+] else
					[ ] break
			[ ] 
			[ ] //Go to Current month to start verification
			[ ] QuickenWindow.SetActive()
			[ ] sActualMonth=MDIClient.Budget.CurrentMonthStaticText.GetText()
			[+] while (sActualMonth!=sExpectedCurrentMonth)
				[ ] MDIClient.Budget.BackWardMonthButton.Click()
				[ ] sActualMonth=MDIClient.Budget.CurrentMonthStaticText.GetText()
			[ ] 
			[ ] ////Verify Average budget for 12 Months on Annual view
			[ ] ////Select Annual View of budget
			[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sAnnualView)
			[ ] sleep(2)
			[ ] QuickenWindow.SetActive()
			[ ] ///Create the expected budget amounts
			[ ] sExpectedAmount="*{iBudgetAmount}*"
			[+] for (iCount=1 ; iCount<=11;++iCount)
				[ ] sExpectedAmount=sExpectedAmount+"*{iBudgetAmount}*"
			[ ] 
			[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
			[ ] iListCount= MDIClient.Budget.ListBox.GetItemCount() +1
			[ ] 
			[ ] ///Verify on annual view
			[+] for (iCount=1 ; iCount<=iListCount;++iCount)
				[ ] 
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
				[ ] bMatch = MatchStr("*{iBudgetAmount}*", sActual)
				[+] if (bMatch)
					[ ] break
			[+] if(bMatch)
				[ ] ReportStatus("Verify that User is able to update average budget using {sOption} on Annual View.." ,PASS, "The Average budget for 12 months:has been updated:{sActual} as expected:{sExpectedAmount} using {sOption} for category: {sCategory} on Annual View.")
			[+] else
				[ ] ReportStatus("Verify that User is able to update average budget using {sOption} on Annual View." ,FAIL, "The Average budget for 12 months couldn't be updated actualt: {sActual} as expected:{sExpectedAmount} using {sOption} for category: {sCategory} on Annual View.")
			[ ] 
			[ ] 
			[ ] ///Clear the budget values
			[ ] ClearTheBudgetValuesOnAnnualView(sCategory)
		[+] else
			[ ] ReportStatus("Verify that User is able to launch the calculate average budget using {sOption} on category."  , FAIL,"Calculte Average Budget didn't appear using {sOption} on category on Graph View.")
	[+] except
		[ ] ExceptLog()
	[ ] 
	[ ] 
[ ] 
[+] // public STRING GetPreviousMonth ( INTEGER iMonthDiff)
	[ ] // STRING sYear, sDay,sMonth ,sDate
	[ ] // INTEGER  iCount,iMonth ,iYear ,iLastMonth,iYearCounter ,iDay
	[ ] // INTEGER iCurrentMonth
	[ ] // sYear=FormatDateTime(GetDateTime(), "yyyy") 
	[ ] // iYear= VAL(sYear)
	[ ] // sDay=FormatDateTime(GetDateTime(), "d")
	[ ] // iDay=Val(sDay)
	[ ] // sMonth=FormatDateTime(GetDateTime(), "m") //Get current month
	[ ] //  iMonth =Val(sMonth)
	[ ] // iYearCounter=0
	[+] // do
		[ ] // START:
		[ ] // 
		[+] // if(iMonth >= iMonthDiff)
			[ ] // iLastMonth=iMonth-iMonthDiff
			[+] // if (iLastMonth==0)
				[ ] // iLastMonth=12
				[ ] // iYear=iYear-1
			[ ] // 
		[ ] // 
		[+] // else if(iMonth < iMonthDiff)
			[ ] // iLastMonth=iMonth-iMonthDiff
			[ ] // // iLastMonth =iLastMonth*(-1)
			[ ] // iLastMonth=12+iLastMonth
			[ ] // iYear=iYear-1
			[ ] // 
		[ ] // 
		[ ] // 
		[+] // if (iLastMonth==2 && iDay>28)
			[ ] // iDay=28
		[ ] // sDate ="{iLastMonth}" +"/"+str(iDay)+"/"+"{iYear}"
	[+] // except
		[ ] // exceptlog()
	[ ] // return sDate
[ ] 
[ ] 
[ ] 
[+] public INTEGER AddAverageBudget( STRING sCategory,INTEGER iBudgetAmount)
	[ ] 
	[+] do
		[ ] ////first we need to click on the add button associated to everything else to activate the menus
		[+] if(sCategory==sRootEverythingElse)
			[ ] sRootEverythingElse=sEverythingElse
			[ ] MDIClient.Budget.ListBox.TextClick(sCategory)
			[+] if (!MDIClient.Budget.ListBox.Amount.Exists(2))
				[ ] MDIClient.Budget.ListBox.Click(1,952,140)
				[ ] 
			[ ] 
		[+] if (SelectCategoriesToBudget.Exists(4))
			[ ] SelectCategoriesToBudget.Close()
			[ ] iFunctionResult=FAIL
			[ ] ReportStatus("Verify click on everything else add button." ,FAIL, "Click on everything else add button was unsuccessful.")
			[ ] 
		[+] else
			[ ] 
			[ ] iResult=SelectRightClickCategoryOptions(sCategory , sCalculateAverageBudget)
			[ ] 
			[+] if (iResult==PASS)
				[+] if(DlgCalculateAverageBudget.Exists(5))
					[ ] DlgCalculateAverageBudget.SetActive()
					[ ] DlgCalculateAverageBudget.BudgetTextField.SetText(Str(iBudgetAmount))
					[ ] DlgCalculateAverageBudget.ApplyComboBox.Select("to all of 201*")
					[ ] 
					[ ] DlgCalculateAverageBudget.OKButton.Click()
					[ ] WaitForState(DlgCalculateAverageBudget , False , 5)
					[ ] iFunctionResult=PASS
				[+] else
					[ ] ReportStatus("Verify that User is able to launch the calculate average budget using right click on category."  , FAIL,"Calculte Average Budget didn't appear using right click on category on Graph View.")
					[ ] iFunctionResult=FAIL
				[ ] 
			[+] else
				[ ] ReportStatus("Verify claculate average budget option from gear menu on Annual View selected." , FAIL, "Calculate Average Budget option from gear menu on Annual View couldn't be selected.")
				[ ] iFunctionResult=FAIL
	[+] except
		[ ] exceptlog()
		[ ] iFunctionResult=FAIL
	[ ] return iFunctionResult
	[ ] 
[+] public LIST OF ANYTYPE CreateRollOverData( STRING sCategory,INTEGER iBudgetAmount , INTEGER iTxnAmount)
	[+] //Variable decalaration
		[ ] INTEGER iCurrentMonth ,iRollOverMonthCount  ,iRollOverWithNoTxnMonthCount ,iTxnMonthCount ,iRollOverWithNoTxnMonthAmount
		[ ] INTEGER iDiffOfBudgetTxnAmount ,iExpectedTxnRollOverAmount,iExpectedNoTxnRollOverAmount, iRemainingMonths
		[ ] INTEGER iTotalRolloverAmount, iRemainingMonthsAmount
		[ ] STRING sExpectedNoTxnRollOverAmount,sExpectedTxnRollOverAmount, sCurrentMonth
		[ ] LIST OF ANYTYPE lsRolloverData
		[ ] sCurrentMonth=FormatDateTime(GetDateTime(), "m") //Get current month
		[ ]  iCurrentMonth =Val(sCurrentMonth)
		[ ] 
	[ ] 
	[+] do
		[ ] iTxnMonthCount=4
		[ ] iRollOverWithNoTxnMonthAmount=0
		[ ] iRemainingMonths=12 - iCurrentMonth
		[ ] iRemainingMonthsAmount=iRemainingMonths*iBudgetAmount
		[+] if (iCurrentMonth>4)
			[ ] iRollOverWithNoTxnMonthCount=iCurrentMonth-4
			[ ] 
		[+] else
			[ ] iTxnMonthCount= iCurrentMonth
			[ ] iRollOverWithNoTxnMonthCount=0
			[ ] 
		[ ] 
		[+] if (iTxnMonthCount>1)
			[ ] 
			[ ] ///Get rollover amounts for months for whom there are no transactions
			[+] if (iRollOverWithNoTxnMonthCount > 0)
				[ ] sExpectedNoTxnRollOverAmount="*{iBudgetAmount}*"
				[+] for (iCount=2; iCount<=iRollOverWithNoTxnMonthCount; iCount++)
					[ ] sExpectedNoTxnRollOverAmount =sExpectedNoTxnRollOverAmount +"*{iBudgetAmount*iCount}*"
					[ ] 
					[ ] 
				[ ] ///This amount would be needed to add to the amount of first month with transactions
				[ ] iRollOverWithNoTxnMonthAmount=(iBudgetAmount)*(iCount-1)
			[+] else
				[ ] sExpectedNoTxnRollOverAmount=""
			[ ] 
			[ ] ///Get rollover amounts for months for whom there are  transactions
			[ ] iDiffOfBudgetTxnAmount=iBudgetAmount-iTxnAmount
			[ ] 
			[ ] iExpectedTxnRollOverAmount=iRollOverWithNoTxnMonthAmount+iDiffOfBudgetTxnAmount
			[ ] sExpectedTxnRollOverAmount="*{str(iExpectedTxnRollOverAmount)}*"
			[+] for (iCount=2; iCount<=iTxnMonthCount; iCount++)
				[ ] 
				[ ] iExpectedTxnRollOverAmount=iExpectedTxnRollOverAmount + iDiffOfBudgetTxnAmount
				[ ] sExpectedTxnRollOverAmount =sExpectedTxnRollOverAmount +"*{iExpectedTxnRollOverAmount}*"
				[ ] 
				[ ] 
				[ ] 
			[ ] 
			[ ] iTotalRolloverAmount=iExpectedTxnRollOverAmount+iRemainingMonthsAmount
		[+] else
			[ ] iExpectedNoTxnRollOverAmount=0
			[ ] iExpectedTxnRollOverAmount=0
			[ ] sExpectedNoTxnRollOverAmount="0"
			[ ] sExpectedTxnRollOverAmount="0"
			[ ] iTotalRolloverAmount=11*iBudgetAmount
		[+] 
			[ ] 
		[ ] // ListAppend(lsRolloverData,iExpectedTxnRollOverAmount)
		[ ] ListAppend(lsRolloverData,iTotalRolloverAmount)
		[ ] ListAppend(lsRolloverData,sExpectedNoTxnRollOverAmount)
		[ ] ListAppend(lsRolloverData,sExpectedTxnRollOverAmount)
		[ ] 
	[+] except
		[ ] ExceptLog()
	[ ] return lsRolloverData
	[ ] 
	[ ] 
	[ ] 
[ ] 
[+] public VOID SelectBudgetReportOnGraphView( STRING sBudgetReport)
	[+] do
		[ ] QuickenWindow.SetActive()
		[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sGraphView)
		[ ] MDIClient.Budget.BudgetActions.Click()
		[ ] 
		[ ] //// Select Budget Reports
		[ ] 
		[ ] MDIClient.Budget.BudgetActions.TypeKeys(Replicate(KEY_DN, 3))
		[ ] MDIClient.Budget.BudgetActions.TypeKeys(KEY_RT)
		[+] switch (sBudgetReport)
			[+] case sREPORT_CURRENT_BUDGET
				[ ] MDIClient.Budget.BudgetActions.TypeKeys(KEY_ENTER)
			[+] case sREPORT_HISTORICAL_BUDGET
				[ ] MDIClient.Budget.BudgetActions.TypeKeys(Replicate(KEY_DN, 1))
				[ ] MDIClient.Budget.BudgetActions.TypeKeys(KEY_ENTER)
		[ ] 
		[ ] 
	[+] except
		[ ] Exceptlog()
[+] public VOID SelectBudgetOptionOnGraphAnnualView( STRING sView ,STRING sOption)
	[+] do
		[ ] 
		[+] switch (sView)
			[ ] 
			[+] case "Graph View"
				[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sGraphView)
				[+] switch (sOption)
					[+] case "Rollup"
						[ ] iKeyDown=2
					[+] case  "Include Reminders"
						[ ] iKeyDown=1
					[ ] 
			[+] case "Annual View"
				[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sAnnualView)
				[+] switch (sOption)
					[+] case "Rollup"
						[ ] iKeyDown=3
					[+] case  "Include Reminders"
						[ ] iKeyDown=1
					[ ] 
			[ ] 
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] MDIClient.Budget.BudgetActions.Click()
		[ ] 
		[ ] MDIClient.Budget.BudgetActions.TypeKeys(Replicate(KEY_DN, 4))
		[ ] MDIClient.Budget.BudgetActions.TypeKeys(KEY_RT)
		[ ] MDIClient.Budget.BudgetActions.TypeKeys(Replicate(KEY_DN, iKeyDown))
		[ ] MDIClient.Budget.BudgetActions.TypeKeys(KEY_ENTER)
		[ ] sleep(3)
	[+] except
		[ ] Exceptlog()
	[ ] 
[ ] 
[+] public INTEGER GetNoOfDaysInCurrentMonth ()
	[ ] STRING sYear, sDay,sMonth ,sCurrentDay
	[ ] BOOLEAN bLeapYear
	[ ] INTEGER iCurrentDay
	[+] do
		[ ] sCurrentDay=FormatDateTime(GetDateTime(), "dd") 
		[ ] iCurrentDay = VAL(sCurrentDay)
		[ ] //Year 
		[ ] sYear=FormatDateTime(GetDateTime(), "yyyy") 
		[ ] iYear =VAL (sYear)
		[+] if  (iYear%400==0)
			[ ] bLeapYear=TRUE
		[+] else if (iYear%4==0)
			[ ] bLeapYear=TRUE
		[+] else if (iYear%100==0)
			[ ] bLeapYear=FALSE
		[+] else
			[ ] bLeapYear=FALSE
			[ ] 
		[ ] //Get current month as January 2014
		[ ] sCurrentMonth=FormatDateTime(GetDateTime(), "m") 
		[ ] iCurrentMonth = VAL(sCurrentMonth)
		[ ] 
		[ ] 
		[ ] //
		[ ] //Calculate no. of days in current month
		[+] if (iCurrentMonth==1 ||iCurrentMonth==3 ||iCurrentMonth==5 ||iCurrentMonth==7 ||iCurrentMonth==8 ||iCurrentMonth==10 || iCurrentMonth==12)
			[ ] iDays=31
		[+] else if (iCurrentMonth==4 ||iCurrentMonth==6 ||iCurrentMonth==9 ||iCurrentMonth==11)
			[ ] iDays=30
		[+] else if (bLeapYear)
			[ ] iDays=29
		[+] else
			[ ] iDays=28
		[ ] 
	[+] except
		[ ] exceptlog()
	[ ] return iDays
[ ] 
[+] // //##########Test 1 - Verify the display of cents in Goal bars of graph view and grid view. #####################
	[ ] // // ********************************************************
	[+] // // TestCase Name:	 Test1_VerifyTheDisplayOfCentsInGoalBarsOfGraphViewAndGridView
		[ ] // //
		[ ] // // DESCRIPTION:
		[ ] // // This testcase will Verify the display of cents in Goal bars of graph view and grid view.
		[ ] // //
		[ ] // // PARAMETERS:		None
		[ ] // //
		[ ] // // RETURNS:			Pass 		If the display of cents in Goal bars of graph view and grid view.
		[ ] // //						Fail		      If any error occurs
		[ ] // //
		[ ] // // REVISION HISTORY:
		[ ] // // Mukesh created  March 24 2014
		[ ] // //
	[ ] // // ********************************************************
[+] // testcase Test1_VerifyTheDisplayOfCentsInGoalBarsOfGraphViewAndGridView() appstate QuickenBaseState
	[+] // //--------------Variable Declaration-------------
		[ ] // 
		[ ] // sExpectedAnnualViewSpending = "$6,538.05"
		[ ] // sExpectedAnnualViewBudget ="$124,077.08"
		[ ] // sExpectedAnnualViewSavings ="$0.00"
		[ ] // sExpectedAnnualViewLeft ="$117,539.03"
		[ ] // 
		[ ] // 
		[ ] // 
		[ ] // STRING sDecimal ="."
		[+] // if(FileExists(sbudgetedataFile))
			[+] // // if (QuickenWindow.Exists(5))
				[ ] // // QuickenWindow.Close()
			[ ] // // Waitforstate(QuickenWindow,False,5)
			[ ] // DeleteFile(sbudgetedataFile)
			[ ] // sleep(2)
			[ ] // SYS_CopyFile (sbudgetedataFileSource , sbudgetedataFile)
			[ ] // sleep(2)
	[ ] // iResult=OpenDataFile(sBudgetFileName)
	[+] // if (iResult==PASS)
		[+] // if(QuickenWindow.Exists(5))
			[ ] // QuickenWindow.SetActive()
			[ ] // //Navigate to Budget
			[ ] // iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
			[+] // if (iResult==PASS)
				[ ] // sleep(2)
				[ ] // QuickenWindow.SetActive()
				[ ] // MDIClient.Budget.BudgetActions.Click()
				[ ] // MDIClient.Budget.BudgetActions.TypeKeys(Replicate(KEY_DN, 4))
				[ ] // MDIClient.Budget.BudgetActions.TypeKeys(KEY_RT)
				[ ] // MDIClient.Budget.BudgetActions.TypeKeys(KEY_ENTER)
				[ ] // sleep(2)
				[ ] // QuickenWindow.SetActive()
				[ ] // 
				[ ] // 
				[ ] // ///Verify the display of cents in Goal bars of graph view 
				[ ] // 
				[ ] // 
				[ ] // ///Verify cents displayed in Graph View Summary Total Spending
				[ ] // sActualSummaryTotalSpending = MDIClient.Budget.GraphViewSummaryTotalSpending.GetProperty("Caption")
				[ ] // bMatch = MatchStr("*{sDecimal}*" , sActualSummaryTotalSpending)
				[+] // if (bMatch)
					[ ] // ReportStatus("Verify the display of cents in Goal bars of graph view." , PASS , "Cents displayed for the Graph View Summary Total Spending: {sActualSummaryTotalSpending}.")
				[+] // else
					[ ] // ReportStatus("Verify the display of cents in Goal bars of graph view." , FAIL , "Cents didn't display for the Graph View Summary Total Spending: {sActualSummaryTotalSpending}.")
				[ ] // 
				[ ] // ///Verify cents displayed in Graph View Summary Total Budget
				[ ] // sActualSummaryTotalBudget = MDIClient.Budget.GraphViewSummaryTotalBudget.GetProperty("Caption")
				[ ] // bMatch = MatchStr("*{sDecimal}*"  , sActualSummaryTotalBudget)
				[+] // if (bMatch)
					[ ] // ReportStatus("Verify the display of cents in Goal bars of graph view." , PASS , "Cents displayed for the Graph View Summary Total Budget: {sActualSummaryTotalBudget}.")
				[+] // else
					[ ] // ReportStatus("Verify the display of cents in Goal bars of graph view." , FAIL , "Cents didn't display for the Graph View Summary Total Budget: {sActualSummaryTotalBudget}.")
				[ ] // ///Verify cents displayed in Graph View Summary Total Savings
				[ ] // sActualSummaryTotalSavings = MDIClient.Budget.GraphViewSummaryTotalSavings.GetProperty("Caption")
				[ ] // bMatch = MatchStr("*{sDecimal}*" , sActualSummaryTotalSavings)
				[+] // if (bMatch)
					[ ] // ReportStatus("Verify the display of cents in Goal bars of graph view." , PASS , "Cents displayed for the Graph View Summary Total Savings: {sActualSummaryTotalSavings}.")
				[+] // else
					[ ] // ReportStatus("Verify the display of cents in Goal bars of graph view." , FAIL , "Cents didn't display for the Graph View Summary Total Savings: {sActualSummaryTotalSavings}.")
				[ ] // 
				[ ] // ///Verify cents displayed in Graph View Summary Total Left
				[ ] // sActualSummaryTotalLeft = MDIClient.Budget.GraphViewSummaryTotalLeft.GetProperty("Caption")
				[ ] // bMatch = MatchStr("*{sDecimal}*" , sActualSummaryTotalSavings)
				[+] // if (bMatch)
					[ ] // ReportStatus("Verify the display of cents in Goal bars of graph view." , PASS , "Cents displayed for the Graph View Summary Total Left: {sActualSummaryTotalLeft}.")
				[+] // else
					[ ] // ReportStatus("Verify the display of cents in Goal bars of graph view." , FAIL , "Cents didn't display for the Graph View Summary Total Left: {sActualSummaryTotalLeft}.")
				[ ] // 
				[ ] // 
				[ ] // ///Verify the display of cents in Goal bars of Annual View 
				[ ] // QuickenWindow.SetActive()
				[ ] // MDIClient.Budget.BudgetViewTypeComboBox.Select("Annual View")
				[ ] // sleep(2)
				[ ] // QuickenWindow.SetActive()
				[ ] // ///Verify cents displayed in Annual View Summary Total Spending
				[ ] // sActualSummaryTotalSpending = MDIClient.Budget.GraphViewSummaryTotalSpending.GetProperty("Caption")
				[ ] // 
				[+] // if (sExpectedAnnualViewSpending ==sActualSummaryTotalSpending)
					[ ] // ReportStatus("Verify the display of cents in Goal bars of Annual View." , PASS , "Cents displayed for the Annual View Summary Total Spending: {sActualSummaryTotalSpending}.")
				[+] // else
					[ ] // ReportStatus("Verify the display of cents in Goal bars of Annual View." , FAIL , "Cents didn't display for the Annual View Summary Total Spending: {sActualSummaryTotalSpending}.")
				[ ] // 
				[ ] // ///Verify cents displayed in Annual View Summary Total Budget
				[ ] // sActualSummaryTotalBudget = MDIClient.Budget.GraphViewSummaryTotalBudget.GetProperty("Caption")
				[+] // if (sExpectedAnnualViewBudget==sActualSummaryTotalBudget)
					[ ] // ReportStatus("Verify the display of cents in Goal bars of Annual View." , PASS , "Cents displayed for the Annual View Summary Total Budget: {sActualSummaryTotalBudget}.")
				[+] // else
					[ ] // ReportStatus("Verify the display of cents in Goal bars of Annual View." , FAIL , "Cents didn't display for the Annual View Summary Total Budget: {sActualSummaryTotalBudget}.")
				[ ] // ///Verify cents displayed in Annual View Summary Total Savings
				[ ] // sActualSummaryTotalSavings = MDIClient.Budget.GraphViewSummaryTotalSavings.GetProperty("Caption")
				[+] // if (sExpectedAnnualViewSavings==sActualSummaryTotalSavings)
					[ ] // ReportStatus("Verify the display of cents in Goal bars of Annual View." , PASS , "Cents displayed for the Annual View Summary Total Savings: {sActualSummaryTotalSavings}.")
				[+] // else
					[ ] // ReportStatus("Verify the display of cents in Goal bars of Annual View." , FAIL , "Cents didn't display for the Annual View Summary Total Savings: {sActualSummaryTotalSavings}.")
				[ ] // 
				[ ] // ///Verify cents displayed in Annual View Summary Total Left
				[ ] // sActualSummaryTotalLeft = MDIClient.Budget.GraphViewSummaryTotalLeft.GetProperty("Caption")
				[+] // if (bMatch)
					[ ] // ReportStatus("Verify the display of cents in Goal bars of Annual View." , PASS , "Cents displayed for the Annual View Summary Total Left: {sActualSummaryTotalLeft}.")
				[+] // else
					[ ] // ReportStatus("Verify the display of cents in Goal bars of Annual View." , FAIL , "Cents didn't display for the Annual View Summary Total Left: {sActualSummaryTotalLeft}.")
				[ ] // 
			[+] // else
				[ ] // ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
		[+] // else
			[ ] // ReportStatus("Verify Quicken Exists. ", FAIL , "Quicken does not exist.") 
	[+] // else
		[ ] // ReportStatus("Open Data File",FAIL,"Data File: {sBudgetFileName} couldn't be opened.")
	[ ] // 
	[ ] // 
	[ ] // 
	[ ] // 
[ ] // 
[+] // //##########Test 2:Verify that the "All Categories" option is removed from the category picker on budget page. #####################
	[ ] // // ********************************************************
	[+] // // TestCase Name:	 Test2_VerifyThatAllCategoriesOptionIsRemovedFromTheCategoryPickerOnBudget
		[ ] // //
		[ ] // // DESCRIPTION:
		[ ] // // This testcase will Verify that the "All Categories" option is removed from the category picker on budget page.
		[ ] // //
		[ ] // // PARAMETERS:		None
		[ ] // //
		[ ] // // RETURNS:			Pass 		If "All Categories" option is removed from the category picker on budget page.
		[ ] // //						Fail		      If any error occurs
		[ ] // //
		[ ] // // REVISION HISTORY:
		[ ] // // Mukesh created  March 25 2014
		[ ] // //
	[ ] // // ********************************************************
[ ] // 
[+] // testcase Test2_VerifyThatAllCategoriesOptionIsRemovedFromTheCategoryPickerOnBudget() appstate none
	[+] // //--------------Variable Declaration-------------
		[ ] // 
		[ ] // 
	[ ] // 
	[ ] // 
	[+] // if(QuickenWindow.Exists(5))
		[ ] // QuickenWindow.SetActive()
		[ ] // MDIClient.Budget.BudgetViewTypeComboBox.Select("Graph View")
		[ ] // sleep(2)
		[ ] // QuickenWindow.SetActive()
		[ ] // MDIClient.Budget.SelectCategoryToBudgetLink.Click()
		[+] // if (SelectCategoriesToBudget.Exists(4))
			[ ] // SelectCategoriesToBudget.SetActive()
			[+] // if (SelectCategoriesToBudget.AllCategories.Exists())
				[ ] // ReportStatus("Verify that the All Categories option is removed from the category picker on budget page.", FAIL , "All Categories option still available on the Select Categories to Budget dialog.")
			[+] // else
				[ ] // ReportStatus("Verify that the All Categories option is removed from the category picker on budget page.", PASS , "All Categories option is removed from the Select Categories to Budget dialog.") 
			[ ] // SelectCategoriesToBudget.Cancel.Click()
			[ ] // WaitForState(SelectCategoriesToBudget , False , 3)
		[+] // else
			[ ] // ReportStatus("Verify Select Categories to Budget dialog appeared. ", FAIL , "Select Categories to Budget dialog didn't appear.") 
		[ ] // 
		[ ] // 
	[+] // else
		[ ] // ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
	[ ] // 
[ ] // 
[ ] // 
[+] // //##########Test 3: Verify that Parent categories are presented in hierarchical display even if only some subcategories belong to the Custom category group. #####################
	[ ] // // ********************************************************
	[+] // // TestCase Name:	 Test3_VerifyThatParentCategoriesPresentedInHierarchicalOrderIfSomeSubcategoriesBelongToTheCustomCategoryGroup
		[ ] // //
		[ ] // // DESCRIPTION:
		[ ] // // This testcase will Verify that the "All Categories" option is removed from the category picker on budget page.
		[ ] // //
		[ ] // // PARAMETERS:		None
		[ ] // //
		[ ] // // RETURNS:			Pass 		If "All Categories" option is removed from the category picker on budget page.
		[ ] // //						Fail		      If any error occurs
		[ ] // //
		[ ] // // REVISION HISTORY:
		[ ] // // Mukesh created  March 25 2014
		[ ] // //
	[ ] // // ********************************************************
[ ] // 
[+] // testcase Test3_VerifyThatParentCategoriesPresentedInHierarchicalOrderIfSomeSubcategoriesBelongToTheCustomCategoryGroup() appstate none
	[+] // //--------------Variable Declaration-------------
		[ ] // STRING  sCategoryType ,sExpectedCategory , sParentCategory ,sCategory
		[ ] // INTEGER iCatCount
		[ ] // lsCategoryList = {"Mileage" , "Parking"}
		[ ] // sCategoryType ="Personal Expenses"
		[ ] // sParentCategory = "Auto & Transport"
		[ ] // iCatCount=1
		[ ] // 
		[ ] // 
	[ ] // 
	[+] // if(QuickenWindow.Exists(5))
		[ ] // QuickenWindow.SetActive()
		[ ] // ////Create CustomCategory Group 
		[ ] // iResult=AddCustomCategoryGroup (sCustomCatGroup )
		[+] // if (iResult==PASS)
			[ ] // ReportStatus("Verify Custom Category Group created. ", PASS , " Custom Category Group: {sCustomCatGroup} created.") 
			[ ] // ///Verify custom category group added successfully
			[ ] // iResult=AddCategoriesToCustomCategoryGroup  (sCustomCatGroup ,sCategoryType, lsCategoryList)
			[+] // if (iResult==PASS)
				[ ] // ReportStatus("Verify Categories  {lsCategoryList} is added to the custom group: {sCustomCatGroup}.", PASS , "Categories {lsCategoryList} is added to the custom group: {sCustomCatGroup}.") 
				[ ] // 
				[ ] // ////Navigate to budget and add custom categories to budget
				[ ] // iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
				[+] // if (iResult==PASS)
					[ ] // QuickenWindow.SetActive()
					[ ] // MDIClient.Budget.SelectCategoryToBudgetLink.Click()
					[+] // if (SelectCategoriesToBudget.Exists(4))
						[ ] // SelectCategoriesToBudget.SetActive()
						[ ] // SelectCategoriesToBudget.TextClick(sCustomCatGroup)
						[+] // for each sCategory in lsCategoryList
							[ ] // SelectCategoriesToBudget.TextClick(sCategory)
							[ ] // 
						[ ] // SelectCategoriesToBudget.OK.Click()
						[ ] // WaitForState(SelectCategoriesToBudget , False ,3)
						[ ] // 
						[ ] // ///Verify the categories added to the budget
						[ ] // QuickenWindow.SetActive()
						[ ] // sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
						[ ] // iListCount= MDIClient.Budget.ListBox.GetItemCount() +1
						[ ] // 
						[+] // for(iCount= 1; iCount <= iListCount;  iCount++)
							[ ] // sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount-1))
							[ ] // bMatch = MatchStr("*{sCustomCatGroup}*", sActual)
							[+] // if (bMatch)
								[ ] // iCounter = iCount +1
								[+] // for (iCount= iCounter; iCount < iCounter+ListCount(lsCategoryList);  iCount++)
									[ ] // 
									[ ] // //// iCatCount is used to iterate the category list
									[ ] // 
									[ ] // sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount-1))
									[ ] // sExpectedCategory="{sParentCategory}:*{lsCategoryList[iCatCount]}"
									[ ] // bMatch = MatchStr("*{sExpectedCategory}*", sActual)
									[+] // if (bMatch)
										[ ] // ReportStatus("Verify that Parent categories are presented in hierarchical display even if some subcategories belong to the Custom category group. ", PASS , " Category:{lsCategoryList[iCatCount]} displayed as expected:{sActual} with parent: {sParentCategory} under custom group:{sCustomCatGroup}.") 
									[+] // else
										[ ] // ReportStatus("Verify that Parent categories are presented in hierarchical display even if some subcategories belong to the Custom category group. ", FAIL , " Category:{lsCategoryList[iCatCount]} didn't display as expected:{sExpectedCategory} with parent: {sParentCategory} under custom group:{sCustomCatGroup}, actual category is: {sActual}.") 
									[ ] // iCatCount++
								[ ] // break
						[ ] // 
						[ ] // 
						[ ] // 
					[+] // else
						[ ] // ReportStatus("Verify Select Categories to Budget dialog appeared. ", FAIL , "Select Categories to Budget dialog didn't appear.") 
				[+] // else
					[ ] // ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
				[ ] // 
			[+] // else
				[ ] // ReportStatus("Verify Categories {lsCategoryList} is added to the custom group: {sCustomCatGroup}.", FAIL , "Categories {lsCategoryList} didn't add to the custom group: {sCustomCatGroup}.") 
		[+] // else
			[ ] // ReportStatus("Verify Custom Category Group created. ", FAIL , " Custom Category Group: {sCustomCatGroup} couldn't be created.") 
		[ ] // 
		[ ] // 
		[ ] // 
	[+] // else
		[ ] // ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
	[ ] // 
	[ ] // 
[ ] // 
[+] // //##########Test 4: Verify the user has an option that determines whether hierarchy is displayed or not.. #####################
	[ ] // // ********************************************************
	[+] // // TestCase Name:	 Test1_VerifyTheDisplayOfCentsInGoalBarsOfGraphViewAndGridView
		[ ] // //
		[ ] // // DESCRIPTION:
		[ ] // // This testcase will Verify that Verify the user has an option that determines whether hierarchy is displayed or not.
		[ ] // //
		[ ] // // PARAMETERS:		None
		[ ] // //
		[ ] // // RETURNS:			Pass 		If user has an option that determines whether hierarchy is displayed or not.
		[ ] // //						Fail		      If any error occurs
		[ ] // //
		[ ] // // REVISION HISTORY:
		[ ] // // Mukesh created  March 30 2014
		[ ] // //
	[ ] // // ********************************************************
[ ] // 
[+] // testcase Test4_VerifyThatUserHasAnOptionThatDeterminesWhetherHierarchyIsDisplayedOrNot() appstate none
	[+] // //--------------Variable Declaration-------------
		[ ] // STRING sView
		[ ] // List of ANYTYPE lsBudgetViews
		[ ] // lsCategoryList = {"Mileage" , "Parking"}
		[ ] // 
		[ ] // sCategoryType ="Personal Expenses"
		[ ] // sParentCategory = "Auto & Transport"
		[ ] // iCatCount=1
	[ ] // 
	[+] // if(QuickenWindow.Exists(5))
		[ ] // QuickenWindow.SetActive()
		[ ] // sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
		[ ] // iListCount= MDIClient.Budget.ListBox.GetItemCount() +1
		[ ] // 
		[+] // for(iCount= 1; iCount <= 5;  iCount++)
			[ ] // sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount-1))
			[ ] // bMatch = MatchStr("*{sCustomCatGroup}*", sActual)
		[ ] // 
		[ ] // 
		[ ] // //// Verify category hierarchy on graph view
		[ ] // MDIClient.Budget.BudgetViewTypeComboBox.Select(sGraphView)
		[ ] // MDIClient.Budget.BudgetActions.Click()
		[ ] // MDIClient.Budget.BudgetActions.TypeKeys(Replicate(KEY_DN, 4))
		[ ] // MDIClient.Budget.BudgetActions.TypeKeys(KEY_RT)
		[ ] // MDIClient.Budget.BudgetActions.TypeKeys(Replicate(KEY_DN, 2))
		[ ] // MDIClient.Budget.BudgetActions.TypeKeys(KEY_ENTER)
		[ ] // sleep(2)
		[ ] // QuickenWindow.SetActive()
		[ ] // ////Enable the parent rollup option
		[ ] // QuickenWindow.SetActive()
		[ ] // sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
		[ ] // iListCount= MDIClient.Budget.ListBox.GetItemCount() +1
		[ ] // 
		[+] // for(iCount= 1; iCount <= iListCount;  iCount++)
			[ ] // sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount-1))
			[ ] // bMatch = MatchStr("*{sCustomCatGroup}*", sActual)
			[+] // if (bMatch)
				[ ] // iCounter = iCount +1
				[+] // for(iCount= iCounter; iCount <= iListCount;  iCount++)
					[ ] // sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount-1))
					[ ] // bMatch = MatchStr("*{sParentCategory}*", sActual)
					[+] // if (bMatch)
						[ ] // 
						[ ] // iCounter = iCount +1
						[+] // for (iCount= iCounter; iCount < iCounter+ListCount(lsCategoryList);  iCount++)
							[ ] // 
							[ ] // //// iCatCount is used to iterate the category list
							[ ] // 
							[ ] // sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount-1))
							[ ] // bMatch = MatchStr("*{lsCategoryList[iCatCount]}*", sActual)
							[+] // if (bMatch)
								[ ] // ReportStatus("Verify that Parent categories are presented in hierarchical display even if some subcategories belong to the Custom category group. ", PASS , " Category:{lsCategoryList[iCatCount]} displayed as expected:{sActual} with parent: {sParentCategory} under custom group:{sCustomCatGroup}.") 
							[+] // else
								[ ] // ReportStatus("Verify that Parent categories are presented in hierarchical display even if some subcategories belong to the Custom category group. ", FAIL , " Category:{lsCategoryList[iCatCount]} didn't display as expected: with parent: {sParentCategory} under custom group:{sCustomCatGroup}, actual category is: {sActual}.") 
							[ ] // iCatCount++
						[ ] // break
						[ ] // 
						[ ] // break
				[ ] // break
		[ ] // 
		[ ] // //// Verify category hierarchy on Annual view
		[ ] // MDIClient.Budget.BudgetViewTypeComboBox.Select(sAnnualView)
		[ ] // sleep(5)
		[ ] // QuickenWindow.SetActive()
		[ ] // 
		[+] // do
			[ ] // MDIClient.Budget.ListBox.TextClick(sParentCategory)
			[ ] // ReportStatus("Verify that Parent Category displayed as expected" , PASS, "Parent Category: {sParentCategory} displayed as expected.")
		[+] // except
			[ ] // ReportStatus("Verify that Parent Category displayed as expected" , FAIL, "Parent Category: {sParentCategory} didn't display as expected.")
		[ ] // 
		[+] // do
			[ ] // MDIClient.Budget.ListBox.TextClick(lsCategoryList[1])
			[ ] // ReportStatus("Verify that Sub Category is displayed as expected" , PASS, "Sub Category: {lsCategoryList[1]} displayed as expected.")
		[+] // except
			[ ] // ReportStatus("Verify that Sub Category is displayed as expected" , FAIL, "Sub Category: {lsCategoryList[1]} didn't display as expected.")
		[ ] // 
		[+] // do
			[ ] // MDIClient.Budget.ListBox.TextClick(lsCategoryList[2])
			[ ] // ReportStatus("Verify that Sub Category is displayed as expected" , PASS, "Sub Category: {lsCategoryList[2]} displayed as expected.")
		[+] // except
			[ ] // ReportStatus("Verify that Sub Category is displayed as expected" , FAIL, "Sub Category: {lsCategoryList[2]} didn't display as expected.")
		[ ] // 
		[+] // do
			[ ] // MDIClient.Budget.ListBox.TextClick(sCustomCatGroup)
			[ ] // MDIClient.Budget.ListBox.TextClick(sCustomCatGroup)
			[ ] // ReportStatus("Verify that Custom Category displayed as expected" , PASS, "Custom Category: {sCustomCatGroup} displayed as expected.")
		[+] // except
			[ ] // ReportStatus("Verify that Custom Category displayed as expected" , FAIL, "Custom Category: {sCustomCatGroup} didn't display as expected.")
		[ ] // 
		[ ] // iResult=DeleteCustomCategoryGroup(sCustomCatGroup)
		[+] // if (iResult==PASS)
			[ ] // ReportStatus("Verify Custom category group is deleted." , PASS , "Custom category group: {sCustomCatGroup} has been deleted.")
		[+] // else
			[ ] // ReportStatus("Verify Custom category group is deleted." , FAIL , "Custom category group: {sCustomCatGroup} couldn't be deleted.")
		[ ] // 
		[ ] // 
		[ ] // 
		[ ] // 
	[+] // else
		[ ] // ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
	[ ] // 
	[ ] // 
[ ] 
[ ] 
[+] //##########Test 31: As a user, I want the default reset value to be 0 and able to set specific value in Annual view. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test1_VerifyTheDisplayOfCentsInGoalBarsOfGraphViewAndGridView
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify the default Zero state of the budget category
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If default Zero state of the budget category is correct
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  June 07 2014
		[ ] //
	[ ] // ********************************************************
[ ] 
[+] testcase Test31_VerifyTheDefaultZeroStateOfBudgetCategory() appstate QuickenBaseState
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] sBudgetName = "BudgetTest"
		[ ] bMatch=FALSE
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] iBudgetAmount=0
		[ ] ///Remove category type and parent category from the list
		[ ] lsCategoryList = lsExcelData[1]
		[ ] sCategoryType =lsCategoryList[1]
		[ ] ListDelete (lsCategoryList ,1)
		[ ] ListDelete (lsCategoryList ,1)
		[ ] //Remove NULL from category list
		[ ] 
		[+] for( iCounter=1; iCounter <=ListCount (lsCategoryList) ; iCounter++)
			[+] if (lsCategoryList[iCounter]==NULL)
				[ ] ListDelete (lsCategoryList ,iCounter)
				[ ] iCounter--
				[ ] 
		[ ] iListCount=ListCount (lsCategoryList)
		[ ] ///Get the first sub-category
		[ ] sCategory=trim(lsCategoryList[1])
		[ ] 
		[ ] 
	[ ] iResult=DataFileCreate(sBudgetFileName)
	[+] if (iResult==PASS)
		[+] if(QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
			[ ] iResult = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4])
			[ ] // Verify checking Account is created
			[+] if (iResult==PASS)
				[ ] ReportStatus("{lsAddAccount[1]} Account", PASS, "{lsAddAccount[1]} Account -  {lsAddAccount[2]}  is created successfully")
				[ ] //Navigate to Budget
				[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
				[+] if (iResult==PASS)
					[ ] sleep(2)
					[ ] QuickenWindow.SetActive()
					[ ] iResult =AddBudget(sBudgetName)
					[+] if (iResult==PASS)
						[ ] QuickenWindow.SetActive()
						[ ] iResult=SelectOneCategoryToBudget(sCategoryType ,sCategory)
						[+] if (iResult==PASS)
							[ ] ReportStatus("Verify category added to the budget.", PASS , "Category: {sCategory} of type: {sCategoryType} couldn't be added to the budget.")
							[ ] 
							[ ] ////Verify the default state of the Auto & transport category on Annual view
							[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sAnnualView)
							[ ] sleep(2)
							[ ] sExpectedPattern=""
							[+] for (iCounter=1 ;  iCounter<= 12; iCounter++)
								[ ] sExpectedPattern=sExpectedPattern+"*{str(iBudgetAmount)}*"
							[ ] ///Verify zero budgeted amount on details view
							[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
							[ ] iListCount =MDIClient.Budget.ListBox.GetItemCount() 
							[ ] 
							[+] for(iCounter= 1; iCounter <= iListCount;  iCounter++)
								[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCounter))
								[ ] bMatch = MatchStr("*{sExpectedPattern}*",sActual)
								[+] if (bMatch)
									[ ] break
							[+] if (bMatch)
								[ ] ReportStatus("Verify the default Zero state of the budget category on Details View .", PASS ,"The default Zero state of the budget category: {sCategory} is expected:{sExpectedPattern} on Details View.")
							[+] else
								[ ] ReportStatus("Verify the default Zero state of the budget category on Details View .", FAIL ,"The actual default Zero state of the budget category: {sCategory} is NOT as expected:{sExpectedPattern} on Details View.")
							[ ] 
							[ ] ////Verify the default state of the Auto & transport category on Graph view
							[ ] //Calculate total budget 
							[ ] iTotalBudget =0
							[ ] iTotalExpense= 0
							[ ] iTotalBalance=0
							[ ] 
							[ ] 
							[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sGraphView)
							[ ] sleep(2)
							[ ] MDIClient.Budget.BudgetDurationComboBox.Select("Yearly")
							[ ] MDIClient.Budget.BudgetDurationComboBox.Select("Yearly")
							[ ] MDIClient.Budget.BudgetDurationComboBox.Select("Yearly")
							[ ] sleep(1)
							[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
							[ ] iListCount =MDIClient.Budget.ListBox.GetItemCount() 
							[ ] ///Verify zero budgeted amount on Graph view
							[+] for(iCounter= 1; iCounter <= iListCount;  iCounter++)
								[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCounter))
								[ ] bMatch = MatchStr("*{sCategory}*{iTotalExpense}*{iTotalBalance}*{iTotalBudget}*",sActual)
								[+] if (bMatch)
									[ ] break
							[+] if (bMatch)
								[ ] ReportStatus("Verify the default Zero state of the budget category on Graph View .", PASS ,"The total expense:{iTotalExpense}, total left: {iTotalBalance} and total budget: {iTotalBudget} is as expected for category: {sCategory} for default zero state budget on Graph View.")
							[+] else
								[ ] ReportStatus("Verify the default Zero state of the budget category on Graph View .", FAIL ,"The expected total expense:{iTotalExpense}, total left: {iTotalBalance} and total budget: {iTotalBudget} is NOT as actual:{sActual} for category: {sCategory} for default zero state budget on Graph View.")
						[+] else
							[ ] ReportStatus("Verify category added to the budget.", FAIL , "Category: {sCategory} of type: {sCategoryType} couldn't be added to the budget.") 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Budget is created. ", FAIL , "Budget: {sBudgetName} couldn't be created.") 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
				[ ] 
			[+] else
				[ ] ReportStatus("{lsAddAccount[1]} Account", FAIL, "{lsAddAccount[1]} Account -  {lsAddAccount[2]}  is not created")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
	[+] else
		[ ] ReportStatus("Create Data File",FAIL,"Data File: {sBudgetFileName} couldn't be created.")
	[ ] 
	[ ] 
[ ] 
[ ] 
[ ] 
[+] //##########Test 5: Verify that by default hierarchy off is displayed after creating new budget. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test1_VerifyTheDisplayOfCentsInGoalBarsOfGraphViewAndGridView
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that Verify the user has an option that determines whether hierarchy is displayed or not.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If user has an option that determines whether hierarchy is displayed or not.
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  March 30 2014
		[ ] //
	[ ] // ********************************************************
[ ] 
[+] testcase Test5_VerifyThatByDefaultHierarchyOffIsDisplayedAfterCreatingNewBudget() appstate none
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] sBudgetName = "BudgetTest"
		[ ] bMatch=FALSE
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] 
		[ ] 
	[ ] //Navigate to Budget
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] iResult=DeleteBudget()
		[+] if (iResult==PASS)
			[ ] sleep(2)
			[ ] QuickenWindow.SetActive()
			[ ] iResult =AddBudget(sBudgetName)
			[+] if (iResult==PASS)
				[ ] QuickenWindow.SetActive()
				[ ] ///Addcategories to budget
				[+] for ( iCount=1 ; iCount <=2 ; iCount++)
					[ ] lsCategoryList = lsExcelData[iCount]
					[+] if (lsCategoryList[1]==NULL)
						[ ] break
					[ ] sCategoryType =lsCategoryList[1]
					[ ] ListDelete (lsCategoryList ,1)
					[+] if (iCount==1)
						[ ] //To delete the parent category for first list
						[ ] ListDelete (lsCategoryList ,1)
						[ ] 
					[ ] iResult=AddCategoriesToBudget(sCategoryType , lsCategoryList)
					[+] if (iResult==PASS)
						[ ] ReportStatus("Verify categories added to the budget.", PASS , "Categories: {lsCategoryList} of type: {sCategoryType} added to the budget.") 
						[ ] bMatch=TRUE
					[+] else
						[ ] ReportStatus("Verify categories added to the budget.", FAIL , "Categories: {lsCategoryList} of type: {sCategoryType} couldn't be added to the budget.") 
						[ ] bMatch=FALSE
				[ ] 
				[ ] ////Verify category hierarchy after adding categories to the budget
				[+] if (bMatch)
					[ ] ////Verify category hierarchy on Graph View of budget
					[ ] QuickenWindow.SetActive()
					[ ] //Verify category hierarchy for added categories to the budget if parent category is not added to the budget
					[ ] 
					[ ] 
					[ ] lsCategoryList=NULL
					[ ] lsCategoryList = lsExcelData[1]
					[ ] sCategoryType =lsCategoryList[1]
					[ ] sParentCategory=lsCategoryList[2]
					[ ] ListDelete (lsCategoryList ,1)
					[ ] ListDelete (lsCategoryList ,1)
					[ ] 
					[ ] 
					[ ] iResult=VerifyCategoryHierarchyOnBudgetOnGraphView(sCategoryType ,sParentCategory, lsCategoryList , TRUE )
					[+] if (iResult==PASS)
						[ ] ReportStatus("Verify that by default hierarchy off is displayed after creating new budget on Graph View.", PASS , "Default hierarchy off is displayed after creating new budget on Graph View.") 
					[+] else
						[ ] ReportStatus("Verify that by default hierarchy off is displayed after creating new budget on Graph View.", FAIL , "Default hierarchy off didn't display after creating new budget as expected on Graph View") 
					[ ] 
					[ ] //Verify category hierarchy for added categories to the budget if parent category is also added to the budget
					[ ] 
					[ ] lsCategoryList=NULL
					[ ] 
					[ ] lsCategoryList = lsExcelData[2]
					[ ] sCategoryType =lsCategoryList[1]
					[ ] sParentCategory=lsCategoryList[2]
					[ ] ListDelete (lsCategoryList ,1)
					[ ] ListDelete (lsCategoryList ,1)
					[ ] ListInsert(lsCategoryList ,1 ,sEverythingElse)
					[ ] 
					[ ] iResult=VerifyCategoryHierarchyOnBudgetOnGraphView(sCategoryType ,sParentCategory, lsCategoryList , FALSE )
					[+] if (iResult==PASS)
						[ ] ReportStatus("Verify that by default hierarchy off is displayed after creating new budget on Graph View", PASS , "Default hierarchy off is displayed after creating new budget on Graph View.") 
					[+] else
						[ ] ReportStatus("Verify that by default hierarchy off is displayed after creating new budget  on Graph View", FAIL , "Default hierarchy off didn't display after creating new budget as expected on Graph View.") 
					[ ] 
					[ ] ////Verify category hierarchy on Annual View of budget
					[ ] //Verify category hierarchy for added categories to the budget if parent category is not added to the budget
					[ ] 
					[ ] 
					[ ] lsCategoryList=NULL
					[ ] lsCategoryList = lsExcelData[1]
					[ ] sCategoryType =lsCategoryList[1]
					[ ] sParentCategory=lsCategoryList[2]
					[ ] ListDelete (lsCategoryList ,1)
					[ ] ListDelete (lsCategoryList ,1)
					[ ] 
					[ ] 
					[ ] iResult=VerifyCategoryHierarchyOnBudgetOnAnnualView(sCategoryType ,sParentCategory, lsCategoryList , TRUE )
					[+] if (iResult==PASS)
						[ ] ReportStatus("Verify that by default hierarchy off is displayed after creating new budget on Annual View.", PASS , "Default hierarchy off is displayed after creating new budget on Annual View.") 
					[+] else
						[ ] ReportStatus("Verify that by default hierarchy off is displayed after creating new budget on Annual View.", FAIL , "Default hierarchy off didn't display after creating new budget as expected on Annual View.") 
					[ ] 
					[ ] //Verify category hierarchy for added categories to the budget if parent category is also added to the budget
					[ ] 
					[ ] lsCategoryList=NULL
					[ ] 
					[ ] lsCategoryList = lsExcelData[2]
					[ ] sCategoryType =lsCategoryList[1]
					[ ] sParentCategory=lsCategoryList[2]
					[ ] ListDelete (lsCategoryList ,1)
					[ ] ListDelete (lsCategoryList ,1)
					[ ] ListInsert(lsCategoryList ,1 ,sEverythingElse)
					[ ] 
					[ ] iResult=VerifyCategoryHierarchyOnBudgetOnAnnualView(sCategoryType ,sParentCategory, lsCategoryList , FALSE )
					[+] if (iResult==PASS)
						[ ] ReportStatus("Verify that by default hierarchy off is displayed after creating new budget on Annual View", PASS , "Default hierarchy off is displayed after creating new budget on Annual View.") 
					[+] else
						[ ] ReportStatus("Verify that by default hierarchy off is displayed after creating new budget  on Annual View", FAIL , "Default hierarchy off didn't display after creating new budget as expected on Annual View..") 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify categories added to the budget.", FAIL , "Categories couldn't be added to the budget hence testcase can not proceed.") 
			[+] else
				[ ] ReportStatus("Verify Budget is created. ", FAIL , "Budget: {sBudgetName} couldn't be created.") 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify budget gets deleted ", FAIL , "The budget couldn't be deleted.") 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
	[ ] 
[ ] 
[+] //##########Test 6: Verify that If hierarchy display is on and any sub-categories are selected, then all ancestors should be displayed whether budgeted or not.. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test6_VerifyThatIfHierarchyDisplayOnThenParentIsDisplayedWhetherbudgetedOrNot
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that If hierarchy display is on and any sub-categories are selected, then all ancestors should be displayed whether budgeted or not.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If parent is displayed when If hierarchy display is on and whether they are budgeted or not
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  April 08 2014
		[ ] //
	[ ] // ********************************************************
[ ] 
[+] testcase Test6_VerifyThatIfHierarchyDisplayOnThenParentIsDisplayedWhetherbudgetedOrNot() appstate none
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] bMatch=FALSE
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
		[+] if (iResult==PASS)
			[ ] sleep(2)
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] ////Verify category hierarchy on Graph View of budget
			[ ] //// Set Parent rollup on
			[ ] SelectBudgetOptionOnGraphAnnualView(sGraphView,"Rollup")
			[ ] //Verify category hierarchy for added categories to the budget if parent category is not added to the budget
			[ ] 
			[ ] 
			[ ] lsCategoryList=NULL
			[ ] lsCategoryList = lsExcelData[1]
			[ ] sCategoryType =lsCategoryList[1]
			[ ] sParentCategory=lsCategoryList[2]
			[ ] ListDelete (lsCategoryList ,1)
			[ ] ListDelete (lsCategoryList ,1)
			[ ] 
			[ ] 
			[ ] iResult=VerifyCategoryHierarchyOnBudgetOnGraphView(sCategoryType ,sParentCategory, lsCategoryList , FALSE )
			[+] if (iResult==PASS)
				[ ] ReportStatus("Verify that If hierarchy display is on and any sub-categories are selected, then all ancestors should be displayed whether budgeted or not on Graph View.", PASS , "Parent category displayed when rollup is on and Parent is not budgeted on Graph View.") 
			[+] else
				[ ] ReportStatus("Verify that If hierarchy display is on and any sub-categories are selected, then all ancestors should be displayed whether budgeted or not on Graph View.", FAIL , "Parent category didn't displaye when rollup is on and Parent is not budgeted on Graph View.") 
			[ ] 
			[ ] //Verify category hierarchy for added categories to the budget if parent category is also added to the budget
			[ ] 
			[ ] lsCategoryList=NULL
			[ ] 
			[ ] lsCategoryList = lsExcelData[2]
			[ ] sCategoryType =lsCategoryList[1]
			[ ] sParentCategory=lsCategoryList[2]
			[ ] ListDelete (lsCategoryList ,1)
			[ ] ListDelete (lsCategoryList ,1)
			[ ] ListInsert(lsCategoryList ,1 ,sEverythingElse)
			[ ] 
			[ ] iResult=VerifyCategoryHierarchyOnBudgetOnGraphView(sCategoryType ,sParentCategory, lsCategoryList , FALSE )
			[+] if (iResult==PASS)
				[ ] ReportStatus("Verify that If hierarchy display is on and any sub-categories are selected, then all ancestors should be displayed whether budgeted or not on Graph View.", PASS , "Parent category displayed when rollup is on and Parent is not budgeted on Graph View.") 
			[+] else
				[ ] ReportStatus("Verify that If hierarchy display is on and any sub-categories are selected, then all ancestors should be displayed whether budgeted or not on Graph View.", FAIL , "Parent category didn't displaye when rollup is on and Parent is not budgeted on Graph View.") 
			[ ] 
			[ ] ////Verify category hierarchy on Annual View of budget
			[ ] //Verify category hierarchy for added categories to the budget if parent category is not added to the budget
			[ ] 
			[ ] 
			[ ] lsCategoryList=NULL
			[ ] lsCategoryList = lsExcelData[1]
			[ ] sCategoryType =lsCategoryList[1]
			[ ] sParentCategory=lsCategoryList[2]
			[ ] ListDelete (lsCategoryList ,1)
			[ ] ListDelete (lsCategoryList ,1)
			[ ] 
			[ ] 
			[ ] iResult=VerifyCategoryHierarchyOnBudgetOnAnnualView(sCategoryType ,sParentCategory, lsCategoryList , FALSE )
			[+] if (iResult==PASS)
				[ ] ReportStatus("Verify that If hierarchy display is on and any sub-categories are selected, then all ancestors should be displayed whether budgeted or not on Annual View.", PASS , "Parent category displayed when rollup is on and Parent is not budgeted on Annual View.") 
			[+] else
				[ ] ReportStatus("Verify that If hierarchy display is on and any sub-categories are selected, then all ancestors should be displayed whether budgeted or not on Annual View.", FAIL , "Parent category didn't displaye when rollup is on and Parent is not budgeted on Annual View.") 
			[ ] 
			[ ] //Verify category hierarchy for added categories to the budget if parent category is also added to the budget
			[ ] 
			[ ] lsCategoryList=NULL
			[ ] 
			[ ] lsCategoryList = lsExcelData[2]
			[ ] sCategoryType =lsCategoryList[1]
			[ ] sParentCategory=lsCategoryList[2]
			[ ] ListDelete (lsCategoryList ,1)
			[ ] ListDelete (lsCategoryList ,1)
			[ ] ListInsert(lsCategoryList ,1 ,sEverythingElse)
			[ ] 
			[ ] iResult=VerifyCategoryHierarchyOnBudgetOnAnnualView(sCategoryType ,sParentCategory, lsCategoryList , FALSE )
			[+] if (iResult==PASS)
				[ ] ReportStatus("Verify that If hierarchy display is on and any sub-categories are selected, then all ancestors should be displayed whether budgeted or not on Annual View.", PASS , "Parent category displayed when rollup is on and Parent is budgeted on Annual View.") 
			[+] else
				[ ] ReportStatus("Verify that If hierarchy display is on and any sub-categories are selected, then all ancestors should be displayed whether budgeted or not on Annual View.", FAIL , "Parent category didn't displaye when rollup is on and Parent is budgeted on Annual View.") 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
	[ ] 
[ ] 
[+] //##########Test 7: Verify that if hierarchy is off and any sub-categories are selected, then the full path to the sub-category should also be displayed. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test7_VerifyThatIfHierarchyDisplayOffThenFullPathToTheSubcategoriesShouldBeDisplayed
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that if hierarchy is off and any sub-categories are selected, then the full path to the sub-category should also be displayed.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If hierarchy is off and any sub-categories are selected, then the full path to the sub-category should also be displayed.
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  April 08 2014
		[ ] //Note : TestCase not availble in updated sheet
	[ ] // ********************************************************
[ ] 
[+] testcase Test7_VerifyThatIfHierarchyDisplayOffThenFullPathToTheSubcategoriesShouldBeDisplayed() appstate none
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] bMatch=FALSE
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
		[+] if (iResult==PASS)
			[ ] sleep(2)
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] ////Verify category hierarchy on Graph View of budget
			[ ] //// Set Parent rollup Off
			[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sGraphView)
			[ ] MDIClient.Budget.BudgetActions.Click()
			[ ] MDIClient.Budget.BudgetActions.TypeKeys(Replicate(KEY_DN, 4))
			[ ] MDIClient.Budget.BudgetActions.TypeKeys(KEY_RT)
			[ ] MDIClient.Budget.BudgetActions.TypeKeys(Replicate(KEY_DN, 2))
			[ ] MDIClient.Budget.BudgetActions.TypeKeys(KEY_ENTER)
			[ ] sleep(2)
			[ ] 
			[ ] 
			[ ] 
			[ ] //Verify category hierarchy for added categories to the budget if parent category is not added to the budget
			[ ] 
			[ ] 
			[ ] lsCategoryList=NULL
			[ ] lsCategoryList = lsExcelData[1]
			[ ] sCategoryType =lsCategoryList[1]
			[ ] sParentCategory=lsCategoryList[2]
			[ ] ListDelete (lsCategoryList ,1)
			[ ] ListDelete (lsCategoryList ,1)
			[ ] 
			[ ] 
			[ ] iResult=VerifyCategoryHierarchyOnBudgetOnGraphView(sCategoryType ,sParentCategory, lsCategoryList , TRUE )
			[+] if (iResult==PASS)
				[ ] ReportStatus("Verify that if hierarchy is off and any sub-categories are selected, then the full path to the sub-category should also be displayed.", PASS , "Full Path of the subcategories displayed when rollup is off and parent categories not budgeted on Graph View.") 
			[+] else
				[ ] ReportStatus("Verify that if hierarchy is off and any sub-categories are selected, then the full path to the sub-category should also be displayed.", FAIL , "Full Path of the subcategories didn't display when rollup is off and parent categories not budgeted on Graph View.") 
			[ ] 
			[ ] //Remove parent category for Bills & Utilities
			[ ] //Verify category hierarchy for added categories to the budget if parent category is not added to the budget on Graph View
			[ ] 
			[ ] 
			[ ] lsCategoryList=NULL
			[ ] 
			[ ] lsCategoryList = lsExcelData[2]
			[ ] sCategoryType =lsCategoryList[1]
			[ ] sParentCategory=lsCategoryList[2]
			[ ] ListDelete (lsCategoryList ,1)
			[ ] ListDelete (lsCategoryList ,1)
			[ ] 
			[ ] 
			[ ] MDIClient.Budget.SelectCategoryToBudgetLink.Click()
			[+] if (SelectCategoriesToBudget.Exists(4))
				[ ] SelectCategoriesToBudget.SetActive()
				[ ] SelectCategoriesToBudget.TextClick(sCategoryType)
				[ ] SelectCategoriesToBudget.TextClick(sParentCategory)
				[ ] SelectCategoriesToBudget.OK.Click()
				[ ] WaitForState(SelectCategoriesToBudget , False ,3)
				[ ] QuickenWindow.SetActive()
				[ ] 
				[ ] 
				[ ] 
				[ ] iResult=VerifyCategoryHierarchyOnBudgetOnGraphView(sCategoryType ,sParentCategory, lsCategoryList , TRUE )
				[+] if (iResult==PASS)
					[ ] ReportStatus("Verify that if hierarchy is off and any sub-categories are selected, then the full path to the sub-category should also be displayed.", PASS , "Full Path of the subcategories displayed when rollup is off and parent categories not budgeted on Graph View.") 
				[+] else
					[ ] ReportStatus("Verify that if hierarchy is off and any sub-categories are selected, then the full path to the sub-category should also be displayed.", FAIL , "Full Path of the subcategories didn't display when rollup is off and parent categories not budgeted on Graph View.") 
				[ ] 
				[ ] ////Verify category hierarchy on Annual View of budget
				[ ] //Verify category hierarchy for added categories to the budget if parent category is not added to the budget on Annual View
				[ ] 
				[ ] 
				[ ] lsCategoryList=NULL
				[ ] lsCategoryList = lsExcelData[1]
				[ ] sCategoryType =lsCategoryList[1]
				[ ] sParentCategory=lsCategoryList[2]
				[ ] ListDelete (lsCategoryList ,1)
				[ ] ListDelete (lsCategoryList ,1)
				[ ] 
				[ ] 
				[ ] iResult=VerifyCategoryHierarchyOnBudgetOnAnnualView(sCategoryType ,sParentCategory, lsCategoryList , TRUE )
				[+] if (iResult==PASS)
					[ ] ReportStatus("Verify that if hierarchy is off and any sub-categories are selected, then the full path to the sub-category should also be displayed.", PASS , "Full Path of the subcategories displayed when rollup is off and parent categories not budgeted on Annual View.") 
				[+] else
					[ ] ReportStatus("Verify that if hierarchy is off and any sub-categories are selected, then the full path to the sub-category should also be displayed.", FAIL , "Full Path of the subcategories didn't display when rollup is off and parent categories not budgeted on Annual View.") 
				[ ] 
				[ ] //Verify category hierarchy for added categories to the budget if parent category is not added to the budget on Annual View
				[ ] 
				[ ] lsCategoryList=NULL
				[ ] 
				[ ] lsCategoryList = lsExcelData[2]
				[ ] sCategoryType =lsCategoryList[1]
				[ ] sParentCategory=lsCategoryList[2]
				[ ] ListDelete (lsCategoryList ,1)
				[ ] ListDelete (lsCategoryList ,1)
				[ ] 
				[ ] iResult=VerifyCategoryHierarchyOnBudgetOnAnnualView(sCategoryType ,sParentCategory, lsCategoryList , TRUE )
				[+] if (iResult==PASS)
					[ ] ReportStatus("Verify that if hierarchy is off and any sub-categories are selected, then the full path to the sub-category should also be displayed.", PASS , "Full Path of the subcategories displayed when rollup is off and parent categories not budgeted on Annual View.") 
				[+] else
					[ ] ReportStatus("Verify that if hierarchy is off and any sub-categories are selected, then the full path to the sub-category should also be displayed.", FAIL , "Full Path of the subcategories didn't display when rollup is off and parent categories not budgeted on Annual View.") 
			[+] else
				[ ] ReportStatus("Verify Select Categories to Budget dialog appeared. ", FAIL , "Select Categories to Budget dialog didn't appear.") 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
	[ ] 
[ ] 
[+] //##########Test 8:Verify that if no sub-categories are budgeted, then parent should be editable and there should not be a row for Everything Else.. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test8_VerifyThatIfHierarchyDisplayOnAndNoSubCatbudgetedThenEverythingElseRowIsNotPresent
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that if no sub-categories are budgeted, then parent should be editable and there should not be a row for Everything Else.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If hierarchy is on and any sub-categories are not budegted,then parent should be editable and there should not be a row for Everything Else.
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  April 09 2014
		[ ] //
	[ ] // ********************************************************
[ ] 
[+] testcase Test8_VerifyThatIfHierarchyDisplayOnAndNoSubCatbudgetedThenEverythingElseRowIsNotPresent() appstate none
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] STRING sParentCategoryAmount
		[ ] sBudgetName = "BudgetTest"
		[ ] bMatch=FALSE
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] sParentCategoryAmount="50"
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
		[+] if (iResult==PASS)
			[ ] sleep(2)
			[ ] 
			[ ] iResult=DeleteBudget()
			[+] if (iResult==PASS)
				[ ] iResult=AddBudget(sBudgetName)
				[+] if (iResult==PASS)
					[ ] ReportStatus("Verify budget gets added.", PASS, "Budget: {sBudgetName} has been added.")
					[ ] 
					[ ] QuickenWindow.SetActive()
					[ ] 
					[ ] ////Verify category hierarchy on Graph View of budget
					[ ] //// Set Parent rollup on
					[ ] SelectBudgetOptionOnGraphAnnualView(sGraphView,"Rollup")
					[ ] sleep(2)
					[ ] 
					[ ] ///Add Auto & transport to budget
					[ ] lsCategoryList=NULL
					[ ] lsCategoryList = lsExcelData[1]
					[ ] sCategoryType =lsCategoryList[1]
					[ ] sParentCategory=lsCategoryList[2]
					[ ] ListDelete (lsCategoryList ,1)
					[ ] ListDelete (lsCategoryList ,1)
					[ ] 
					[ ] iResult=SelectOneCategoryToBudget(sCategoryType ,sParentCategory)
					[+] if (iResult==PASS)
						[ ] ////Verify Auto & transport on Graph view
						[ ] iResult=VerifyParentCategoryHierarchyOnBudgetOnAnnualAndGraphView(sCategoryType , sParentCategory , TRUE)
						[+] if (iResult==PASS)
							[ ] ReportStatus("Verify that if no sub-categories are budgeted, then parent should be editable and there should not be a row for Everything Else.", PASS , "Parent category: {sParentCategory} displayed correctly on Graph View.") 
						[+] else
							[ ] ReportStatus("Verify that if no sub-categories are budgeted, then parent should be editable and there should not be a row for Everything Else.", FAIL , "Parent category: {sParentCategory} displayed inccorrectly on Graph View") 
						[ ] 
						[ ] QuickenWindow.SetActive()
						[ ] ///Verify parent category is editable
						[ ] MDIClient.Budget.ListBox.Amount.SetFocus()
						[ ] MDIClient.Budget.ListBox.Amount.SetText(sParentCategoryAmount)
						[ ] sActual =MDIClient.Budget.ListBox.Amount.GetText()
						[+] if (sActual==sParentCategoryAmount)
							[ ] ReportStatus("Verify that if no sub-categories are budgeted, then parent should be editable and there should not be a row for Everything Else.", PASS , "Parent category: {sParentCategory} has been edited with amount: {sActual} on Graph View.") 
						[+] else
							[ ] ReportStatus("Verify that if no sub-categories are budgeted, then parent should be editable and there should not be a row for Everything Else.", FAIL , "Parent category: {sParentCategory} couldn't be edited with expected amount: {sParentCategoryAmount} as actual amount: {sActual} is on Graph View.") 
						[ ] 
						[ ] // ////Verify everything else didn't display on graph view
						[ ] QuickenWindow.SetActive()
						[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
						[ ] iListCount= MDIClient.Budget.ListBox.GetItemCount()-1
						[ ] 
						[+] for(iCount= 0; iCount <= iListCount;  iCount++)
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
							[ ] bMatch = MatchStr("*{sCategoryType}*", sActual)
							[+] if (bMatch)
								[ ] iCounter = iCount +1
								[+] for(iCount= iCounter; iCount <= iListCount;  iCount++)
									[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
									[ ] bMatch = MatchStr("*{sEverythingElse}*", sActual)
									[+] if (bMatch)
										[+] if (iCount==iListCount)
											[ ] bMatch=TRUE
											[ ] break
											[ ] 
										[ ] break
								[+] if (bMatch)
									[ ] ReportStatus("Verify Everything Else Category found on budget graph view." , PASS , "Everything Else: {sEverythingElse} couldn't be found on budget graph view when no subcategories added and rollup is on.")
									[ ] 
								[+] else
									[ ] ReportStatus("Verify Everything Else Category found on budget graph view." , FAIL , "Everything Else: {sEverythingElse}  found on budget graph view when no subcategories added and rollup is on.")
								[ ] break
								[ ] 
						[+] if (bMatch==False)
							[ ] ReportStatus("Verify Category type found on budget graph view." , FAIL , "Category type: {sCategoryType} couldn't be found on budget graph view.")
						[ ] 
						[ ] ////Verify Auto & transport on Annual view
						[ ] iResult=VerifyParentCategoryHierarchyOnBudgetOnAnnualAndGraphView(sCategoryType , sParentCategory , FALSE)
						[+] if (iResult==PASS)
							[ ] ReportStatus("Verify that if no sub-categories are budgeted, then parent should be editable and there should not be a row for Everything Else.", PASS , "Parent category: {sParentCategory} displayed correctly on Annual View.") 
						[+] else
							[ ] ReportStatus("Verify that if no sub-categories are budgeted, then parent should be editable and there should not be a row for Everything Else.", FAIL , "Parent category: {sParentCategory} displayed inccorrectly on Annual View") 
						[ ] 
						[ ] 
						[+] do
							[ ] QuickenWindow.SetActive()
							[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sAnnualView)
							[ ] sleep(3)
							[ ] 
							[ ] MDIClient.Budget.ListBox.TextClick(Upper(sCategoryType))
							[ ] ReportStatus("Verify that Category Type  displayed as expected on Annual View." , PASS, "Category Type: {sCategoryType} displayed as expected on Annual View.")
							[ ] 
							[ ] //Verify that Parent Category is hidden when category type is collapsed
							[+] do
								[ ] MDIClient.Budget.ListBox.TextClick(sEverythingElse)
								[ ] ReportStatus("Verify that Everything Else is hidden when category type is collapsed" , FAIL, "Everything Else: {sEverythingElse} didn't hide under the Category Type: {sCategoryType} on Annual View.")
								[ ] 
							[+] except
								[ ] ReportStatus("Verify that Everything Else  is hidden when category type is collapsed" , PASS, "Everything Else: {sEverythingElse} is hidden under the Category Type: {sCategoryType} on Annual View.")
								[ ] 
								[ ] //Expand category type
								[ ] MDIClient.Budget.ListBox.TextClick(Upper(sCategoryType))
								[ ] 
								[+] do
									[ ] MDIClient.Budget.ListBox.TextClick(sEverythingElse)
									[ ] ReportStatus("Verify Everything Else Category found on budget graph view." , FAIL , "Everything Else: {sEverythingElse} found on budget Annual view when no subcategories added and rollup is on.")
									[ ] 
								[+] except
									[ ] ReportStatus("Verify Everything Else Category found on budget graph view." , PASS , "Everything Else: {sEverythingElse} couldn't be found on budget Annual view when no subcategories added and rollup is on.")
							[ ] 
						[+] except
							[ ] ReportStatus("Verify that Category Type displayed on Annual View" , FAIL, "Category Type: {sCategoryType} didn't display on annual View")
						[ ] 
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify category added to the budget.", FAIL , "Category: {sParentCategory} of type: {sCategoryType} couldn't be added to the budget.") 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify budget gets added.", FAIL, "Budget: {sBudgetName} couldn't be added.")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify budget gets deleted.", FAIL, "Budget: {sBudgetName} couldn't be deleted.")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
	[ ] 
[ ] 
[+] //##########Test 9:Verify that if some sub-categories are budgeted then the parent is read-only, row for Everything Else is added and the Everything Else row is editable. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test9_VerifyThatIfHierarchyDisplayOnAndSomeSubCatbudgetedThenEverythingElseRowShouldBeEditable
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that if some sub-categories are budgeted then the parent is read-only, row for Everything Else is added and the Everything Else row is editable.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		f some sub-categories are budgeted then the parent is read-only, row for Everything Else is added and the Everything Else row is editable.
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  April 09 2014
		[ ] //
	[ ] // ********************************************************
[ ] 
[+] testcase Test9_VerifyThatIfHierarchyDisplayOnAndSomeSubCatbudgetedThenEverythingElseRowShouldBeEditable() appstate none
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] STRING sParentCategoryAmount ,sEverythingElseAmount
		[ ] sBudgetName = "BudgetTest"
		[ ] bMatch=FALSE
		[ ] sParentCategoryAmount="50"
		[ ] sEverythingElseAmount="100"
		[ ] sAmount="30"
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] lsCategoryList = lsExcelData[1]
		[ ] 
		[ ] //Remove null values from the category list
		[+] for( iCounter=1; iCounter <=ListCount (lsCategoryList) ; iCounter++)
			[+] if (lsCategoryList[iCounter]==NULL)
				[ ] ListDelete (lsCategoryList ,iCounter)
				[ ] iCounter--
				[ ] 
		[ ] sCategoryType = trim(lsCategoryList[1])
		[ ] sParentCategory = trim(lsCategoryList[2])
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
		[+] if (iResult==PASS)
			[ ] QuickenWindow.SetActive()
			[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sGraphView)
			[ ] ///Addcategories to budget
			[ ] //Delete the category type and parent category from the list
			[ ] ListDelete (lsCategoryList ,1)
			[ ] ListDelete (lsCategoryList ,1)
			[ ] iResult=AddCategoriesToBudget(sCategoryType , lsCategoryList)
			[+] if (iResult==PASS)
				[ ] ReportStatus("Verify categories added to the budget.", PASS , "Categories: {lsCategoryList} of type: {sCategoryType} added to the budget.") 
				[ ] bMatch=TRUE
			[+] else
				[ ] ReportStatus("Verify categories added to the budget.", FAIL , "Categories: {lsCategoryList} of type: {sCategoryType} couldn't be added to the budget.") 
				[ ] bMatch=FALSE
			[ ] 
			[ ] 
			[+] if(bMatch)
				[ ] QuickenWindow.SetActive()
				[ ] // ////Verify Parent category is displayed and not editable on Graph View
				[ ] QuickenWindow.SetActive()
				[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
				[ ] iListCount= MDIClient.Budget.ListBox.GetItemCount()-1
				[ ] ////Find the parent category
				[+] for(iCount= 0; iCount <= iListCount;  iCount++)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
					[ ] bResult = MatchStr("*{sCategoryType}*", sActual)
					[+] if (bResult)
						[ ] iCounter = iCount +1
						[+] for(iCount= iCounter; iCount <= iListCount;  iCount++)
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
							[ ] bMatch = MatchStr("*{sParentCategory}*", sActual)
							[+] if (bMatch)
								[ ] ////Select parent category
								[ ] QwAutoExecuteCommand("LISTBOX_SELECTROW", sHandle, Str(iCount))
								[ ] ////Edit parent category
								[ ] MDIClient.Budget.ListBox.Amount.SetFocus()
								[ ] MDIClient.Budget.ListBox.Amount.SetText(sAmount)
								[ ] MDIClient.Budget.ListBox.TypeKeys(KEY_ENTER)
								[ ] ////Verify parent category is read only
								[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
								[ ] bMatch = MatchStr("*{sAmount}*", sActual)
								[+] if (bMatch)
									[ ] ReportStatus("Verify Parent Category is read only when some sub-categories are budgeted." , FAIL, "Parent Category has been edited with amount: {sAmount}.")
								[+] else
									[ ] ReportStatus("Verify Parent Category is read only when some sub-categories are budgeted."  , PASS, "Parent Category couldn't be edited with amount: {sAmount}.")
								[ ] break
								[ ] 
								[ ] 
						[ ] break
				[+] if (bResult==False)
					[ ] ReportStatus("Verify Category type found on budget graph view." , FAIL , "Category type: {sCategoryType} couldn't be found on budget graph view.")
				[ ] 
				[ ] 
				[ ] // ////Verify everything else displayed on Graph View and is editable
				[+] for(iCount= 0; iCount <= iListCount;  iCount++)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
					[ ] bMatch = MatchStr("*{sCategoryType}*", sActual)
					[+] if (bMatch)
						[ ] iCounter = iCount +1
						[+] for(iCount= iCounter; iCount <= iListCount;  iCount++)
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
							[ ] bMatch = MatchStr("*{sEverythingElse}*", sActual)
							[+] if (bMatch &&  (iCount!=iListCount))
								[ ] 
								[ ] ///Verify EverythingElse category is editable
								[ ] QwAutoExecuteCommand("LISTBOX_SELECTROW", sHandle, Str(iCount))
								[+] do
									[ ] 
									[ ] MDIClient.Budget.ListBox.Amount.SetFocus()
									[ ] MDIClient.Budget.ListBox.Amount.SetText(sEverythingElseAmount)
									[ ] MDIClient.Budget.ListBox.TypeKeys(KEY_ENTER)
									[ ] ReportStatus("Verify Everything Else Category is editable." , PASS, "Everything Else Category has been edited with amount: {sEverythingElseAmount}.")
								[+] except
									[ ] ReportStatus("Verify Everything Else Category is editable." , FAIL, "Everything Else Category couldn't be edited.")
								[ ] break
								[ ] 
								[ ] 
								[ ] 
							[+] else if (iCount==iListCount)
								[+] if (bMatch==FALSE)
									[ ] ReportStatus("Verify Everything Else Category found on budget graph view." , FAIL , "Everything Else for Personal Expenses too not found.")
								[+] else
									[ ] ReportStatus("Verify Everything Else Category found on budget graph view." , FAIL , "Everything Else: {sEverythingElse} couldn't be found on budget graph view when some subcategories added and rollup is on.")
							[+] else
								[ ] continue
						[ ] break
						[ ] 
				[+] if (bMatch==False)
					[ ] ReportStatus("Verify Category type found on budget graph view." , FAIL , "Category type: {sCategoryType} couldn't be found on budget graph view.")
				[ ] 
				[ ] ///Verify everything else on annual view
				[ ] 
				[ ] 
				[+] do
					[ ] QuickenWindow.SetActive()
					[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sAnnualView)
					[ ] sleep(3)
					[+] do
						[ ] MDIClient.Budget.ListBox.TextClick(sParentCategory)
						[ ] 
						[+] do
							[ ] 
							[ ] MDIClient.Budget.ListBox.Amount.SetFocus()
							[ ] MDIClient.Budget.ListBox.Amount.SetText(sAmount)
							[ ] MDIClient.Budget.ListBox.TypeKeys(KEY_ENTER)
							[ ] ReportStatus("Verify Parent Category is not editable on annual view." , FAIL, "Parent Category has been edited with amount: {sAmount} on Annual View.")
						[+] except
							[ ] ReportStatus("Verify Parent Category is not editable on annual view.." , PASS, "Parent Category couldn't be edited with amount: {sAmount} on Annual View.")
						[ ] 
					[+] except
						[ ] ReportStatus("Verify Parent Category not found on budget graph view." , FAIL , "Parent category: {sParentCategory} found on budget Annual view when only subcategories are added and rollup is on.")
					[ ] 
					[ ] 
					[ ] MDIClient.Budget.ListBox.TextClick(Upper(sCategoryType))
					[ ] ReportStatus("Verify that Category Type  displayed as expected on Annual View." , PASS, "Category Type: {sCategoryType} displayed as expected on Annual View.")
					[ ] 
					[ ] //Verify that Parent Category is hidden when category type is collapsed
					[+] do
						[ ] MDIClient.Budget.ListBox.TextClick(sEverythingElse)
						[ ] ReportStatus("Verify that Everything Else is hidden when category type is collapsed" , FAIL, "Everything Else: {sEverythingElse} didn't hide under the Category Type: {sCategoryType} on Annual View.")
						[ ] 
					[+] except
						[ ] ReportStatus("Verify that Everything Else  is hidden when category type is collapsed" , PASS, "Everything Else: {sEverythingElse} is hidden under the Category Type: {sCategoryType} on Annual View.")
						[ ] 
						[ ] //Expand category type
						[ ] MDIClient.Budget.ListBox.TextClick(Upper(sCategoryType))
						[ ] 
						[+] do
							[ ] MDIClient.Budget.ListBox.TextClick(sEverythingElse)
							[ ] MDIClient.Budget.ListBox.Amount.SetFocus()
							[ ] MDIClient.Budget.ListBox.Amount.SetText(sEverythingElseAmount)
							[ ] MDIClient.Budget.ListBox.TypeKeys(KEY_ENTER)
							[ ] ReportStatus("Verify Everything Else Category is editable." , PASS, "Everything Else Category has been edited with amount: {sEverythingElseAmount} on Annual View.")
							[ ] 
							[ ] 
						[+] except
							[ ] ReportStatus("Verify Everything Else Category is editable." , FAIL, "Everything Else Category couldn't be edited on Annual View.")
					[ ] 
				[+] except
					[ ] ReportStatus("Verify that Category Type displayed on Annual View" , FAIL, "Category Type: {sCategoryType} didn't display on annual View")
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify categories added to the budget.", FAIL , "Categories couldn't be added to the budget hence testcase can not proceed.") 
				[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
	[ ] 
[ ] 
[+] // //##########Test 10: Verify that If all sub-categories are budgeted then the parent is read-only and there should not be a row added for Everything Else. #####################
	[ ] // // ********************************************************
	[+] // // TestCase Name:	 Test10_VerifyThatIfHierarchyDisplayOnAllSubCatbudgetedThenParentIsReadOnlyEverythingElseRowShouldNotBePresent
		[ ] // //
		[ ] // // DESCRIPTION:
		[ ] // // This testcase will Test 10: Verify that If all sub-categories are budgeted then the parent is read-only and there should not be a row added for Everything Else.
		[ ] // //
		[ ] // // PARAMETERS:		None
		[ ] // //
		[ ] // // RETURNS:			Pass 	      If all sub-categories are budgeted then the parent is read-only and there should not be a row added for Everything Else.
		[ ] // //						Fail		      If any error occurs
		[ ] // //
		[ ] // // REVISION HISTORY:
		[ ] // // Mukesh created  April 09 2014
		[ ] // //
	[ ] // // ********************************************************
[ ] // 
[+] testcase Test10_VerifyThatIfHierarchyDisplayOnAllSubCatbudgetedThenParentIsReadOnlyEverythingElseRowShouldNotBePresent() appstate none
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] STRING sParentCategoryAmount ,sEverythingElseAmount
		[ ] sAmount="30"
		[ ] sBudgetName = "BudgetTest"
		[ ] bMatch=FALSE
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] lsCategoryList= lsExcelData[5]
		[+] for( iCounter=1; iCounter <=ListCount (lsCategoryList) ; iCounter++)
			[+] if (lsCategoryList[iCounter]==NULL)
				[ ] ListDelete (lsCategoryList ,iCounter)
				[ ] iCounter--
				[ ] 
		[ ] sCategoryType = trim(lsCategoryList[1])
		[ ] sParentCategory = trim(lsCategoryList[2])
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iResult=DeleteBudget()
		[+] if (iResult==PASS)
			[ ] iResult=AddBudget(sBudgetName)
			[+] if (iResult==PASS)
				[ ] ReportStatus("Verify budget gets added.", PASS, "Budget: {sBudgetName} has been added.")
				[ ] ////Select graph view
				[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sGraphView)
				[ ] sleep(3)
				[ ] 
				[ ] ///Addcategories to budget
				[ ] ListDelete (lsCategoryList ,1)
				[ ] 
				[ ] iResult=AddCategoriesToBudget(sCategoryType , lsCategoryList)
				[ ] // iResult=PASS
				[+] if (iResult==PASS)
					[ ] ReportStatus("Verify categories added to the budget.", PASS , "Categories: {lsCategoryList} of type: {sCategoryType} added to the budget.") 
					[ ] bMatch=TRUE
				[+] else
					[ ] ReportStatus("Verify categories added to the budget.", FAIL , "Categories: {lsCategoryList} of type: {sCategoryType} couldn't be added to the budget.") 
					[ ] bMatch=FALSE
				[ ] 
				[ ] 
				[+] if(bMatch)
					[ ] QuickenWindow.SetActive()
					[ ] // ////Verify Parent category is displayed and not editable on Graph View
					[ ] QuickenWindow.SetActive()
					[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
					[ ] iListCount= MDIClient.Budget.ListBox.GetItemCount()-1
					[ ] ////Find the parent category
					[+] for(iCount= 0; iCount <= iListCount;  iCount++)
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
						[ ] bResult = MatchStr("*{sCategoryType}*", sActual)
						[+] if (bResult)
							[ ] iCounter = iCount +1
							[+] for(iCount= iCounter; iCount <= iListCount;  iCount++)
								[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
								[ ] bMatch = MatchStr("*{sParentCategory}*", sActual)
								[+] if (bMatch)
									[ ] ////Select parent category
									[ ] QwAutoExecuteCommand("LISTBOX_SELECTROW", sHandle, Str(iCount))
									[ ] ////Edit parent category
									[ ] MDIClient.Budget.ListBox.Amount.SetText(sAmount)
									[ ] MDIClient.Budget.ListBox.TypeKeys(KEY_ENTER)
									[ ] ////Verify parent category is read only
									[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
									[ ] bMatch = MatchStr("*{sAmount}*", sActual)
									[+] if (bMatch)
										[ ] ReportStatus("Verify Parent Category is read only when all sub-categories are budgeted." , FAIL, "Parent Category has been edited with amount: {sAmount}.")
									[+] else
										[ ] ReportStatus("Verify Parent Category is read only when all sub-categories are budgeted."  , PASS, "Parent Category couldn't be edited with amount: {sAmount}.")
									[ ] break
									[ ] 
									[ ] 
							[ ] break
					[+] if (bResult==False)
						[ ] ReportStatus("Verify Category type found on budget graph view." , FAIL , "Category type: {sCategoryType} couldn't be found on budget graph view.")
					[ ] 
					[ ] // ////Verify everything else not displayed on graph view 
					[ ] QuickenWindow.SetActive()
					[ ] 
					[+] for(iCount= 0; iCount <= iListCount;  iCount++)
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
						[ ] bResult = MatchStr("*{sCategoryType}*", sActual)
						[+] if (bResult)
							[ ] iCounter = iCount +1
							[ ] 
							[+] for(iCount= iCounter; iCount <= iListCount;  iCount++)
								[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
								[ ] bMatch = MatchStr("*{sEverythingElse}*", sActual)
								[+] if (bMatch &&  (iCount!=iListCount))
									[ ] 
									[ ] ReportStatus("Verify Everything Else Category found on budget graph view." , FAIL , "Everything Else: {sEverythingElse}  found on budget graph view when all subcategories added and rollup is on.")
									[ ] 
									[ ] break
								[+] else if (iCount==iListCount)
									[+] if (bMatch==FALSE)
										[ ] ReportStatus("Verify Everything else is not present when only all sub cats are budgeted." , FAIL , "Everything Else for Personal Expenses too not found when subcategories- budgeted , Parent Categoy- Budgeted.")
									[+] else
										[ ] ReportStatus("Verify Everything else is not present when only all sub cats are budgeted." , PASS ,"Everything Else: {sEverythingElse} couldn't be found with:  View- budget graph view , All subcategories - added , Rollup - on , subcategories- budgeted , Parent Categoy- Budgeted.")
									[ ] 
								[+] else
									[ ] continue
							[ ] break
							[ ] 
					[+] if (bResult==False)
						[ ] ReportStatus("Verify Category type found on budget graph view." , FAIL , "Category type: {sCategoryType} couldn't be found on budget graph view.")
					[ ] 
					[ ] 
					[ ] 
					[ ] ///Verify Everything Else on annual view when all categories are added
					[ ] 
					[+] do
						[ ] QuickenWindow.SetActive()
						[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sAnnualView)
						[ ] sleep(3)
						[ ] 
						[ ] MDIClient.Budget.ListBox.TextClick(Upper(sCategoryType))
						[ ] ReportStatus("Verify that Category Type  displayed as expected on Annual View." , PASS, "Category Type: {sCategoryType} displayed as expected on Annual View.")
						[ ] 
						[ ] //Verify that Everything Else is hidden when category type is collapsed
						[+] do
							[ ] MDIClient.Budget.ListBox.TextClick(sEverythingElse)
							[ ] ReportStatus("Verify that Everything Else is hidden when category type is collapsed" , FAIL, "Everything Else: {sEverythingElse} didn't hide under the Category Type: {sCategoryType} on Annual View.")
							[ ] 
						[+] except
							[ ] ReportStatus("Verify that Everything Else  is hidden when category type is collapsed" , PASS, "Everything Else: {sEverythingElse} is hidden under the Category Type: {sCategoryType} on Annual View.")
							[ ] 
							[ ] //Expand category type
							[ ] MDIClient.Budget.ListBox.TextClick(Upper(sCategoryType))
							[ ] 
							[+] do
								[ ] MDIClient.Budget.ListBox.TextClick(sEverythingElse)
								[ ] ReportStatus("Verify Everything Else Category not found on budget graph view." , FAIL , "Everything Else: {sEverythingElse} found on budget Annual view when all subcategories are added and rollup is on.")
								[ ] 
							[+] except
								[ ] ReportStatus("Verify Everything Else Category not found on budget graph view." , PASS , "Everything Else: {sEverythingElse} couldn't be found on budget Annual view when all subcategories are added and rollup is on.")
						[ ] 
					[+] except
						[ ] ReportStatus("Verify that Category Type displayed on Annual View" , FAIL, "Category Type: {sCategoryType} didn't display on annual View")
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify categories added to the budget.", FAIL , "Categories couldn't be added to the budget hence testcase can not proceed.") 
					[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify budget gets added.", FAIL, "Budget: {sBudgetName} couldn't be added.")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify budget gets deleted.", FAIL, "Budget: {sBudgetName} couldn't be deleted.")
			[ ] 
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] //########## Test 11:Verify that If only sub-category are selected, then parent is read-only and there should not be a row added for Everything Else.#####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test11_VerifyThatIfHierarchyDisplayOnAndOnlySubCatbudgetedThenParentIsReadOnlyEverythingElseRowShouldNotBePresent
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Test 11: Verify that If only sub-category are selected, then parent is read-only and there should not be a row added for Everything Else.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	      If only sub-category are selected, then parent is read-only and there should not be a row added for Everything Else.
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  April 09 2014
		[ ] //
	[ ] // ********************************************************
[ ] 
[+] testcase Test11_VerifyThatIfHierarchyDisplayOnAndOnlySubCatbudgetedThenParentIsReadOnlyEverythingElseRowShouldNotBePresent() appstate none
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] STRING sParentCategoryAmount ,sEverythingElseAmount
		[ ] bMatch=FALSE
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] sAmount="30"
		[ ] lsCategoryList = lsExcelData[1]
		[ ] sCategoryType =lsCategoryList[1]
		[ ] sParentCategory=lsCategoryList[2]
		[ ] ListDelete (lsCategoryList ,1)
		[ ] // 
		[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
		[+] if (iResult==PASS)
			[ ] sleep(3)
			[ ] 
			[ ] //// Set Parent rollup on
			[ ] SelectBudgetOptionOnGraphAnnualView(sGraphView,"Rollup")
			[ ] sleep(2)
			[ ] 
			[ ] 
			[ ] ///Remove parent category from budget
			[ ] 
			[ ] 
			[ ] 
			[ ] iResult=SelectOneCategoryToBudget(sCategoryType ,sParentCategory)
			[+] if (iResult==PASS)
				[ ] QuickenWindow.SetActive()
				[ ] 
				[ ] 
				[ ] // ////Verify Parent category is displayed and not editable on Graph View
				[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
				[ ] iListCount= MDIClient.Budget.ListBox.GetItemCount()-1
				[ ] ////Find the parent category
				[+] for(iCount= 0; iCount <= iListCount;  iCount++)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
					[ ] bResult = MatchStr("*{sCategoryType}*", sActual)
					[ ] 
					[+] if (bResult)
						[ ] iCounter = iCount +1
						[+] for(iCount= iCounter; iCount <= iListCount;  iCount++)
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
							[ ] bMatch = MatchStr("*{sParentCategory}*", sActual)
							[+] if (bMatch)
								[ ] ////Verify parent category is read only
								[ ] MDIClient.Budget.ListBox.TextClick(sParentCategory)
								[+] do
									[ ] MDIClient.Budget.ListBox.Amount.SetText(sAmount)
									[ ] ReportStatus("Verify Parent Category is read only when only sub-categories are budgeted." , FAIL, "Parent Category has been edited with amount: {sAmount} when only sub-categories are budgeted.")
								[+] except
									[ ] ReportStatus("Verify Parent Category is read only when only sub-categories are budgeted."  , PASS, "Parent Category couldn't be edited with amount: {sAmount} when only sub-categories are budgeted.")
								[ ] 
								[ ] break
								[ ] 
						[ ] break
				[+] if (bResult==FALSE)
					[ ] ReportStatus("Verify Category type found on budget graph view." , FAIL , "Category type: {sCategoryType} couldn't be found on budget graph view.")
				[ ] 
				[ ] 
				[ ] // ////Verify everything else not displayed on graph view 
				[ ] QuickenWindow.SetActive()
				[ ] 
				[+] for(iCount= 0; iCount <= iListCount;  iCount++)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
					[ ] bResult = MatchStr("*{sCategoryType}*", sActual)
					[+] if (bResult)
						[ ] iCounter = iCount +1
						[ ] 
						[+] for(iCount= iCounter; iCount <= iListCount;  iCount++)
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
							[ ] bMatch = MatchStr("*{sEverythingElse}*", sActual)
							[+] if (bMatch &&  (iCount!=iListCount))
								[ ] ReportStatus("Verify Everything else is not present when only all sub cats are budgeted." , FAIL , "Everything Else: {sEverythingElse} found with:  View- budget graph view , All subcategories - added , Rollup - on , subcategories- budgeted , Parent Categoy- Not Budgeted.")
								[ ] 
								[ ] break
							[+] else if (iCount==iListCount)
								[+] if (bMatch==FALSE)
									[ ] ReportStatus("Verify Everything else is not present when only all sub cats are budgeted." , FAIL , "Everything Else for Personal Expenses too not found when subcategories- budgeted , Parent Categoy- Not Budgeted.")
								[+] else
									[ ] ReportStatus("Verify Everything else is not present when only all sub cats are budgeted." , PASS ,"Everything Else: {sEverythingElse} couldn't be found with:  View- budget graph view , All subcategories - added , Rollup - on , subcategories- budgeted , Parent Categoy- Not Budgeted.")
							[+] else
								[ ] continue
						[ ] break
						[ ] 
				[+] if (bResult==False)
					[ ] ReportStatus("Verify Category type found on budget graph view." , FAIL , "Category type: {sCategoryType} couldn't be found on budget graph view.")
				[ ] 
				[ ] 
				[ ] QuickenWindow.SetActive()
				[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sAnnualView)
				[ ] ///Verify Parent Category is not editable on annual view when only subcategories are added
				[ ] //Clicking two times to set focus
				[ ] MDIClient.Budget.ListBox.TextClick(upper(sCategoryType))
				[ ] MDIClient.Budget.ListBox.TextClick(upper(sCategoryType))
				[+] do
					[ ] MDIClient.Budget.ListBox.TextClick(sParentCategory)
					[ ] 
					[+] do
						[ ] 
						[ ] MDIClient.Budget.ListBox.Amount.SetText(sAmount)
						[ ] MDIClient.Budget.ListBox.TypeKeys(KEY_TAB)
						[ ] ReportStatus("Verify Parent Category is editable." , FAIL, "Parent Category has been edited with amount: {sAmount} on Annual View.")
					[+] except
						[ ] ReportStatus("Verify Parent Category is editable." , PASS, "Parent Category couldn't be edited with amount: {sAmount} on Annual View.")
					[ ] 
					[+] do
						[ ] 
						[ ] MDIClient.Budget.ListBox.TextClick(sEverythingElse)
						[ ] ReportStatus("Verify Everything else is not present when all sub cats are budgeted." , FAIL, "Everything else is present when all sub cats are budgeted on Annual View.")
					[+] except
						[ ] ReportStatus("Verify Everything else is not present when all sub cats are budgeted." , PASS, "Everything else is not present when all sub cats are budgeted on Annual View.")
					[ ] 
				[+] except
					[ ] ReportStatus("Verify Parent Category not found on budget graph view." , FAIL , "Parent category: {sParentCategory} found on budget Annual view when only subcategories are added and rollup is on.")
				[ ] 
				[ ] 
				[ ] 
			[+] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify category added to the budget.", FAIL , "Category: {sParentCategory} of type: {sCategoryType} couldn't be added to the budget.") 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
	[ ] 
	[ ] 
[ ] 
[ ] 
[ ] // ////#############Settings and Rollover##################/////
[ ] 
[ ] 
[+] //##########Test 7:Verify that User should be able to access the additional edit options via the existing "gear" menu. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test7_VerifyThatUserShouldBeAbleToAccessTheAdditionalEditOptionsViaTheExistingGearMenu
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that User should be able to access the additional edit options via the existing "gear" menu.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If User is able to access the additional edit options via the existing "gear" menu.
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  April 15 2014
		[ ] ////Note : TestCase not availble in updated sheet
	[ ] // ********************************************************
[ ] 
[+] testcase Test7_VerifyThatUserShouldBeAbleToAccessTheAdditionalEditOptionsViaTheExistingGearMenu() appstate none
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] STRING sParentCategoryAmount 
		[ ] bMatch=FALSE
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] sParentCategoryAmount="50"
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] sAmount="0 left"
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
		[+] if (iResult==PASS)
			[ ] sleep(2)
			[ ] iResult=DeleteBudget()
			[+] if (iResult==PASS)
				[ ] iResult=AddBudget(sBudgetName)
				[+] if (iResult==PASS)
					[ ] ReportStatus("Verify budget gets added.", PASS, "Budget: {sBudgetName} has been added.")
					[ ] 
					[ ] QuickenWindow.SetActive()
					[ ] 
					[ ] ////Verify category hierarchy on Graph View of budget
					[ ] 
					[ ] //// Set Parent rollup on
					[ ] SelectBudgetOptionOnGraphAnnualView(sGraphView,"Rollup")
					[ ] sleep(2)
					[ ] 
					[ ] ///Add Auto & transport parent and few sub categoriesto budget
					[ ] lsCategoryList = lsExcelData[1]
					[ ] sCategoryType =lsCategoryList[1]
					[ ] ListDelete (lsCategoryList ,1)
					[ ] iResult=AddCategoriesToBudget(sCategoryType , lsCategoryList)
					[+] if (iResult==PASS)
						[ ] ReportStatus("Verify categories added to the budget.", PASS , "Categories: {lsCategoryList} of type: {sCategoryType} added to the budget.") 
						[ ] bMatch=TRUE
					[+] else
						[ ] ReportStatus("Verify categories added to the budget.", FAIL , "Categories: {lsCategoryList} of type: {sCategoryType} couldn't be added to the budget.") 
						[ ] bMatch=FALSE
					[+] if(bMatch)
						[ ] QuickenWindow.SetActive()
						[ ] ///Verify gear menu options on Garph View
						[ ] // ////Verify  sEditYearlyBudget  option from "gear" menu on Graph View
						[ ] iResult=SelectDeselectGearMenuOptions(sEverythingElse,sEditYearlyBudget)
						[+] if (iResult==PASS)
							[+] if(DlgEditYearlyBudget.Exists(5))
								[ ] DlgEditYearlyBudget.SetActive()
								[ ] DlgEditYearlyBudget.CancelButton.Click()
								[ ] WaitForState(DlgEditYearlyBudget , False , 5)
								[ ] 
								[ ] ReportStatus("Verify that User is able to access the additional edit options via the existing gear menu." , PASS,"Edit Yearly Budget appeared via the existing gear menu on Graph View.")
							[+] else
								[ ] ReportStatus("Verify that User is able to access the additional edit options via the existing gear menu." , FAIL,"Edit Yearly Budget didn't appear via the existing gear menu on Graph View.")
						[+] else
							[ ] ReportStatus("Verify Edit Yearly budget option from gear menu on Graph View selected." , FAIL, "Edit Yearly Budget option from gear menu on Graph View couldn't be selected on Graph View.")
						[ ] 
						[ ] // ////Verify  sCalculateAverageBudget  option from "gear" menu on Graph View
						[ ] iResult=SelectDeselectGearMenuOptions(sEverythingElse,sCalculateAverageBudget)
						[+] if (iResult==PASS)
							[+] if(DlgCalculateAverageBudget.Exists(5))
								[ ] DlgCalculateAverageBudget.SetActive()
								[ ] DlgCalculateAverageBudget.CancelButton.Click()
								[ ] WaitForState(DlgCalculateAverageBudget , False , 5)
								[ ] 
								[ ] ReportStatus("Verify that User is able to access the additional edit options via the existing gear menu." , PASS,"Calculate Average Budget appeared via the existing gear menu on Graph View.")
							[+] else
								[ ] ReportStatus("Verify that User is able to access the additional edit options via the existing gear menu." , FAIL,"Calculate Average Budget didn't appear via the existing gear menu on Graph View.")
						[+] else
							[ ] ReportStatus("Verify Edit Yearly budget option from gear menu on Graph View selected." , FAIL, "Edit Yearly Budget option from gear menu on Graph View couldn't be selected on Graph View.")
						[ ] 
						[ ] 
						[ ] ///Verify gear menu options on Annual View
						[ ] // ////Verify  sEditYearlyBudget  option from "gear" menu on Annual View
						[ ] iResult=SelectDeselectGearMenuOptions(sEverythingElse ,sEditYearlyBudget , FALSE)
						[+] if (iResult==PASS)
							[+] if(DlgEditYearlyBudget.Exists(5))
								[ ] DlgEditYearlyBudget.SetActive()
								[ ] DlgEditYearlyBudget.CancelButton.Click()
								[ ] WaitForState(DlgEditYearlyBudget , False , 5)
								[ ] 
								[ ] ReportStatus("Verify that User is able to access the additional edit options via the existing gear menu." , PASS,"Edit Yearly Budget appeared via the existing gear menu on Annual View.")
							[+] else
								[ ] ReportStatus("Verify that User is able to access the additional edit options via the existing gear menu." , FAIL,"Edit Yearly Budget didn't appear via the existing gear menu on Annual View.")
						[+] else
							[ ] ReportStatus("Verify Edit Yearly budget option from gear menu on Graph View selected." , FAIL, "Edit Yearly Budget option from gear menu on Graph View couldn't be selected on Annual View.")
						[ ] 
						[ ] // ////Verify  sCalculateAverageBudget  option from "gear" menu on Annual View
						[ ] iResult=SelectDeselectGearMenuOptions(sEverythingElse,sCalculateAverageBudget , FALSE)
						[+] if (iResult==PASS)
							[+] if(DlgCalculateAverageBudget.Exists(5))
								[ ] DlgCalculateAverageBudget.SetActive()
								[ ] DlgCalculateAverageBudget.CancelButton.Click()
								[ ] WaitForState(DlgCalculateAverageBudget , False , 5)
								[ ] 
								[ ] ReportStatus("Verify that User is able to access the additional edit options via the existing gear menu." , PASS,"Calculate Average Budge appeared via the existing gear menu on Annual View.")
							[+] else
								[ ] ReportStatus("Verify that User is able to access the additional edit options via the existing gear menu." , FAIL,"Calculate Average Budge didn't appear via the existing gear menu on Annual View.")
						[+] else
							[ ] ReportStatus("Verify Edit Yearly budget option from gear menu on Graph View selected." , FAIL, "Edit Yearly Budget option from gear menu on Graph View couldn't be selected on Annual View.")
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify categories added to the budget.", FAIL , "Categories couldn't be added to the budget hence testcase can not proceed.") 
						[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify budget gets added.", FAIL, "Budget: {sBudgetName} couldn't be added.")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify budget gets deleted.", FAIL, "Budget: {sBudgetName} couldn't be deleted.")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
	[ ] 
[ ] 
[+] //##########Test 8: Verify that User should be able to access the additional edit options via right-click menu. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test8_VerifyThatUserShouldBeAbleToAccessTheAdditionalGearOptionsViaRightClickMenu
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that User should be able to access the additional edit options via right-click menu.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If User is able to access the additional edit options via the existing "edit" menu.
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  April 15 2014
		[ ] ////Note : TestCase not availble in updated sheet
	[ ] // ********************************************************
[ ] 
[+] testcase Test8_VerifyThatUserShouldBeAbleToAccessTheAdditionalGearOptionsViaRightClickMenu() appstate none
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] bMatch=FALSE
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] lsCategoryList = lsExcelData[1]
		[ ] sCategoryType =lsCategoryList[1]
		[ ] sCategory=lsCategoryList[3]
		[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
		[+] if (iResult==PASS)
			[ ] sleep(2)
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] ////Select Graph View of budget
			[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sGraphView)
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] ///Verify Right Click menu options on Garph View
			[ ] // ////Verify  sEditYearlyBudget  option from "Right Click " menu on Graph View
			[ ] iResult=SelectRightClickCategoryOptions(sCategory , sEditYearlyBudget)
			[+] if (iResult==PASS)
				[+] if(DlgEditYearlyBudget.Exists(5))
					[ ] DlgEditYearlyBudget.SetActive()
					[ ] DlgEditYearlyBudget.CancelButton.Click()
					[ ] WaitForState(DlgEditYearlyBudget , False , 5)
					[ ] 
					[ ] ReportStatus("Verify that User is able to access the additional gear options via the right click menu." , PASS,"Edit Yearly Budget appeared via the right click menu on Graph View.")
				[+] else
					[ ] ReportStatus("Verify that User is able to access the additional gear options via the right click menu." , FAIL,"Edit Yearly Budget didn't appear via the right click menu on Graph View.")
			[+] else
				[ ] ReportStatus("Verify gear Yearly budget option from gear menu on Graph View selected." , FAIL, "gear Yearly Budget option from gear menu on Graph View couldn't be selected on Graph View.")
			[ ] 
			[ ] // ////Verify  sCalculateAverageBudget  option from "Right Click " menu on Graph View
			[ ] iResult=SelectRightClickCategoryOptions(sCategory , sCalculateAverageBudget)
			[+] if (iResult==PASS)
				[+] if(DlgCalculateAverageBudget.Exists(5))
					[ ] DlgCalculateAverageBudget.SetActive()
					[ ] DlgCalculateAverageBudget.CancelButton.Click()
					[ ] WaitForState(DlgCalculateAverageBudget , False , 5)
					[ ] 
					[ ] ReportStatus("Verify that User is able to access the additional gear options via the right click menu." , PASS,"Calculate Average Budget appeared via the right click menu on Graph View.")
				[+] else
					[ ] ReportStatus("Verify that User is able to access the additional gear options via the right click menu." , FAIL,"Calculate Average Budget didn't appear via the right click menu on Graph View.")
			[+] else
				[ ] ReportStatus("Verify gear Yearly budget option from gear menu on Graph View selected." , FAIL, "gear Yearly Budget option from gear menu on Graph View couldn't be selected on Graph View.")
			[ ] ////Select Annual View of budget
			[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sAnnualView)
			[ ] 
			[ ] 
			[ ] ///Verify gear menu options on Annual View
			[ ] // ////Verify "gear Yearly Budget" option from "Right Click " menu on Annual View
			[ ] iResult=SelectRightClickCategoryOptions(sCategory ,sEditYearlyBudget)
			[+] if (iResult==PASS)
				[+] if(DlgEditYearlyBudget.Exists(5))
					[ ] DlgEditYearlyBudget.SetActive()
					[ ] DlgEditYearlyBudget.CancelButton.Click()
					[ ] WaitForState(DlgEditYearlyBudget , False , 5)
					[ ] 
					[ ] ReportStatus("Verify that User is able to access the additional gear options via the right click menu." , PASS,"Edit Yearly Budget appeared via the right click menu on Annual View.")
				[+] else
					[ ] ReportStatus("Verify that User is able to access the additional gear options via the right click menu." , FAIL,"Edit Yearly Budget didn't appear via the right click menu on Annual View.")
			[+] else
				[ ] ReportStatus("Verify gear Yearly budget option from gear menu on Graph View selected." , FAIL, "gear Yearly Budget option from gear menu on Graph View couldn't be selected on Annual View.")
			[ ] 
			[ ] // ////Verify  sCalculateAverageBudget  option from "Right Click " menu on Annual View
			[ ] iResult=SelectRightClickCategoryOptions(sCategory,sCalculateAverageBudget)
			[+] if (iResult==PASS)
				[+] if(DlgCalculateAverageBudget.Exists(5))
					[ ] DlgCalculateAverageBudget.SetActive()
					[ ] DlgCalculateAverageBudget.CancelButton.Click()
					[ ] WaitForState(DlgCalculateAverageBudget , False , 5)
					[ ] 
					[ ] ReportStatus("Verify that User is able to access the additional gear options via the right click menu." , PASS,"Calculate Average Budge appeared via the right click menu on Annual View.")
				[+] else
					[ ] ReportStatus("Verify that User is able to access the additional gear options via the right click menu." , FAIL,"Calculate Average Budge didn't appear via the right click menu on Annual View.")
			[+] else
				[ ] ReportStatus("Verify gear Yearly budget option from gear menu on Graph View selected." , FAIL, "gear Yearly Budget option from gear menu on Graph View couldn't be selected on Annual View.")
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
	[ ] 
[ ] 
[+] //##########Test 9A: Verify that User should be able to edit all 12 months of the currently selected budget from a single dialog using gear menu from Graph View. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test9A_VerifyThatUserShouldBeAbleToAccessTheAdditionalEdit12MonthsOfTheCurrentlySelectedBudgetUsingGearMenuFromGraphView
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Test 9:  Verify that User should be able to edit all 12 months of the currently selected budget from a single dialog using gear menu from Graph View. 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If User is able to edit all 12 months of the currently selected budget from a single dialog using gear menu from Graph View. 
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  April 16 2014
	[ ] // ********************************************************
[ ] 
[+] testcase Test9A_VerifyThatUserShouldBeAbleToAccessTheAdditionalEdit12MonthsOfTheCurrentlySelectedBudgetUsingGearMenuFromGraphView() appstate none
	[ ] 
	[ ] //--------------Variable Declaration-------------
	[+] 
		[ ] STRING sMonth,sCurrentMonth,sCurrentYear,sActualMonth,sExpectedMonth,sExpectedCurrentMonth,sExpectedAmount,sActualAmount
		[ ] INTEGER  iMonth ,iMonthDifference, iBackTraversal ,iForwardTraversal
		[ ] bMatch=FALSE
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] lsCategoryList = lsExcelData[1]
		[ ] sCategoryType =lsCategoryList[1]
		[ ] sCategory=lsCategoryList[3]
		[ ] iBudgetAmount=50
		[ ] sAmount="0 left"
		[ ] iForwardTraversal=11
		[ ] sCurrentMonth=FormatDateTime(GetDateTime(), "mmmm") //Get current month as January 2014
		[ ] sCurrentYear=FormatDateTime(GetDateTime(),"yyyy")
		[ ] sExpectedCurrentMonth=sCurrentMonth+" "+sCurrentYear
		[ ] 
		[ ] 
		[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
		[+] if (iResult==PASS)
			[ ] sleep(2)
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] ////Select Graph View of budget
			[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sGraphView)
			[ ] 
			[ ] 
			[ ] sleep(2)
			[ ] QuickenWindow.SetActive()
			[ ] sCurrentMonth=MDIClient.Budget.CurrentMonthStaticText.GetText()
			[ ] 
			[+] if(sCurrentMonth==sExpectedCurrentMonth)
				[ ] ReportStatus("Verify System date and Month displayed on Budget.",PASS, "System date and Month displayed on Quicken->Planning tab issame as: {sCurrentMonth}.")
				[ ] QuickenWindow.SetActive()
				[ ] 
				[ ] ///Verify gear menu options on Garph View
				[ ] // ////Verify  sEditYearlyBudget  option from "gear" menu on Graph View
				[ ] //In below function clicking on the "0 left" string associated with the first subcategory of the list
				[ ] iResult=SelectDeselectGearMenuOptions(sCategory,sEditYearlyBudget)
				[ ] Verify12MonthsBudgetValuesOnGraphViewAndAnnualView(sCategory, iBudgetAmount, "Gear Menu")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify System date and Month displayed on Budget.", FAIL, "System date: {sExpectedCurrentMonth} and actual Month on Budget: {sCurrentMonth} displayed on Quicken->Planning tab didn't match.")
				[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.")  
	[ ] 
[ ] 
[+] //##########Test 9B: Verify that User should be able to edit all 12 months of the currently selected budget from a single dialog using right click menu from Graph View. ###############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test9B_VerifyThatUserShouldBeAbleToAccessTheAdditionalEdit12MonthsOfTheCurrentlySelectedBudgetUsingRightClickFromGraphView
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Test 9:  Verify that User should be able to edit all 12 months of the currently selected budget from a single dialog using right click menu from Graph View. 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If User is able to edit all 12 months of the currently selected budget from a single dialog using right click from Graph View. 
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  April 18 2014
		[ ] //
	[ ] // ********************************************************
[ ] 
[+] testcase Test9B_VerifyThatUserShouldBeAbleToAccessTheAdditionalEdit12MonthsOfTheCurrentlySelectedBudgetUsingRightClickFromGraphView() appstate none
	[ ] 
	[ ] //--------------Variable Declaration-------------
	[+] 
		[ ] STRING sMonth,sCurrentMonth,sCurrentYear,sActualMonth,sExpectedMonth,sExpectedCurrentMonth,sExpectedAmount,sActualAmount
		[ ] INTEGER  iMonth ,iMonthDifference, iBackTraversal ,iForwardTraversal
		[ ] bMatch=FALSE
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] lsCategoryList = lsExcelData[1]
		[ ] sCategoryType =lsCategoryList[1]
		[ ] sCategory=lsCategoryList[3]
		[ ] iBudgetAmount=50
		[ ] sAmount="0 left"
		[ ] iForwardTraversal=11
		[ ] sCurrentMonth=FormatDateTime(GetDateTime(), "mmmm") //Get current month as January 2014
		[ ] sCurrentYear=FormatDateTime(GetDateTime(),"yyyy")
		[ ] sExpectedCurrentMonth=sCurrentMonth+" "+sCurrentYear
		[ ] 
		[ ] 
		[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
		[+] if (iResult==PASS)
			[ ] sleep(2)
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] ////Select Graph View of budget
			[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sGraphView)
			[ ] 
			[ ] 
			[ ] sleep(2)
			[ ] QuickenWindow.SetActive()
			[ ] sCurrentMonth=MDIClient.Budget.CurrentMonthStaticText.GetText()
			[ ] 
			[+] if(sCurrentMonth==sExpectedCurrentMonth)
				[ ] ReportStatus("Verify System date and Month displayed on Budget.",PASS, "System date and Month displayed on Quicken->Planning tab is same as: {sCurrentMonth}.")
				[ ] QuickenWindow.SetActive()
				[ ] 
				[ ] ///Verify gear menu options on Garph View
				[ ] // ////Verify  sEditYearlyBudget  option from "gear" menu on Graph View
				[ ] iResult=SelectRightClickCategoryOptions(sCategory , sEditYearlyBudget)
				[+] if (iResult==PASS)
					[ ] 
					[ ] //Edit 12 months budget
					[ ] Verify12MonthsBudgetValuesOnGraphViewAndAnnualView(sCategory, iBudgetAmount, "right click")
				[+] else
					[ ] ReportStatus("Verify Edit Yearly budget option from gear menu on Graph View selected." , FAIL, "Edit Yearly Budget option from gear menu on Graph View couldn't be selected on Graph View.")
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify System date and Month displayed on Budget.", FAIL, "System date: {sExpectedCurrentMonth} and actual Month on Budget: {sCurrentMonth} displayed on Quicken->Planning tab didn't match.")
				[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.")  
	[ ] 
[ ] 
[+] //##########Test 9C: Verify that User should be able to edit all 12 months of the currently selected budget from a single dialog using gear menu from Annual View. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test9C_VerifyThatUserShouldBeAbleToAccessTheAdditionalEdit12MonthsOfTheCurrentlySelectedBudgetUsingGearMenuFromAnnualView
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Test 9:  Verify that User should be able to edit all 12 months of the currently selected budget from a single dialog using gear menu from Annual View. 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If User is able to edit all 12 months of the currently selected budget from a single dialog using gear menu from Annual View. 
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  April 16 2014
		[ ] //
	[ ] // ********************************************************
[ ] 
[+] testcase Test9C_VerifyThatUserShouldBeAbleToAccessTheAdditionalEdit12MonthsOfTheCurrentlySelectedBudgetUsingGearMenuFromAnnualView() appstate none
	[ ] 
	[ ] //--------------Variable Declaration-------------
	[+] 
		[ ] STRING sMonth,sCurrentMonth,sCurrentYear,sActualMonth,sExpectedMonth,sExpectedCurrentMonth,sExpectedAmount,sActualAmount
		[ ] INTEGER  iMonth ,iMonthDifference, iBackTraversal ,iForwardTraversal
		[ ] bMatch=FALSE
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] lsCategoryList = lsExcelData[1]
		[ ] sCategoryType =lsCategoryList[1]
		[ ] sCategory=lsCategoryList[3]
		[ ] iBudgetAmount=50
		[ ] sAmount="0 left"
		[ ] iForwardTraversal=11
		[ ] sCurrentMonth=FormatDateTime(GetDateTime(), "mmmm") //Get current month as January 2014
		[ ] sCurrentYear=FormatDateTime(GetDateTime(),"yyyy")
		[ ] sExpectedCurrentMonth=sCurrentMonth+" "+sCurrentYear
		[ ] 
		[ ] 
		[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
		[+] if (iResult==PASS)
			[ ] sleep(2)
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] ////Select Annual View of budget
			[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sGraphView)
			[ ] sleep(4)
			[ ] QuickenWindow.SetActive()
			[ ] sCurrentMonth=MDIClient.Budget.CurrentMonthStaticText.GetText()
			[ ] 
			[+] if(sCurrentMonth==sExpectedCurrentMonth)
				[ ] ReportStatus("Verify System date and Month displayed on Budget.",PASS, "System date and Month displayed on Quicken->Planning tab issame as: {sCurrentMonth}.")
				[ ] QuickenWindow.SetActive()
				[ ] ////Select Annual View of budget
				[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sAnnualView)
				[ ] sleep(4)
				[ ] ///Verify gear menu options on Annual View
				[ ] // ////Verify  sEditYearlyBudget  option from "gear" menu on Annual View
				[ ] iResult=SelectDeselectGearMenuOptionsAnnualView(sCategory , sEditYearlyBudget)
				[+] if (iResult==PASS)
					[ ] ReportStatus("Verify Edit Yearly budget option from gear menu on Annual View selected." , PASS, "Edit Yearly Budget option from gear menu on Annual View selected.")
					[ ] //Edit 12 months budget
					[ ] Verify12MonthsBudgetValuesOnGraphViewAndAnnualView(sCategory, iBudgetAmount, "Gear Menu")
				[+] else
					[ ] ReportStatus("Verify Edit Yearly budget option from gear menu on Annual View selected." , FAIL, "Edit Yearly Budget option from gear menu on Annual View couldn't be selected.")
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify System date and Month displayed on Budget.", FAIL, "System date: {sExpectedCurrentMonth} and actual Month on Budget: {sCurrentMonth} displayed on Quicken->Planning tab didn't match.")
				[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.")  
	[ ] 
[ ] 
[+] //##########Test 9D: Verify that User should be able to edit all 12 months of the currently selected budget from a single dialog using right click menu from Annual View. ###############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test9D_VerifyThatUserShouldBeAbleToAccessTheAdditionalEdit12MonthsOfTheCurrentlySelectedBudgetUsingRightClickFromAnnualView
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Test 9:  Verify that User should be able to edit all 12 months of the currently selected budget from a single dialog using right click menu from Annual View. 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If User is able to edit all 12 months of the currently selected budget from a single dialog using right click from Annual View. 
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  April 18 2014
		[ ] //
	[ ] // ********************************************************
[ ] 
[+] testcase Test9D_VerifyThatUserShouldBeAbleToAccessTheAdditionalEdit12MonthsOfTheCurrentlySelectedBudgetUsingRightClickFromAnnualView() appstate none
	[ ] 
	[ ] //--------------Variable Declaration-------------
	[+] 
		[ ] STRING sMonth,sCurrentMonth,sCurrentYear,sActualMonth,sExpectedMonth,sExpectedCurrentMonth,sExpectedAmount,sActualAmount
		[ ] INTEGER  iMonth ,iMonthDifference, iBackTraversal ,iForwardTraversal
		[ ] bMatch=FALSE
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] lsCategoryList = lsExcelData[1]
		[ ] sCategoryType =lsCategoryList[1]
		[ ] sCategory=lsCategoryList[3]
		[ ] iBudgetAmount=50
		[ ] sAmount="0 left"
		[ ] iForwardTraversal=11
		[ ] sCurrentMonth=FormatDateTime(GetDateTime(), "mmmm") //Get current month as January 2014
		[ ] sCurrentYear=FormatDateTime(GetDateTime(),"yyyy")
		[ ] sExpectedCurrentMonth=sCurrentMonth+" "+sCurrentYear
		[ ] 
		[ ] 
		[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
		[+] if (iResult==PASS)
			[ ] sleep(2)
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] ////Select Annual View of budget
			[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sGraphView)
			[ ] 
			[ ] 
			[ ] sleep(4)
			[ ] QuickenWindow.SetActive()
			[ ] sCurrentMonth=MDIClient.Budget.CurrentMonthStaticText.GetText()
			[ ] 
			[+] if(sCurrentMonth==sExpectedCurrentMonth)
				[ ] ReportStatus("Verify System date and Month displayed on Budget.",PASS, "System date and Month displayed on Quicken->Planning tab is same as: {sCurrentMonth}.")
				[ ] QuickenWindow.SetActive()
				[ ] QuickenWindow.SetActive()
				[ ] ////Select Annual View of budget
				[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sAnnualView)
				[ ] sleep(4)
				[ ] 
				[ ] ///Verify gear menu options on Annual View
				[ ] // ////Verify  sEditYearlyBudget  option from "gear" menu on Graph View
				[ ] iResult=SelectRightClickCategoryOptions(sCategory , sEditYearlyBudget)
				[+] if (iResult==PASS)
					[ ] ReportStatus("Verify Edit Yearly budget option using right click on Annual View selected." , PASS, "Edit Yearly Budget option using right click on Annual View selected.")
					[ ] //Edit 12 months budget
					[ ] Verify12MonthsBudgetValuesOnGraphViewAndAnnualView(sCategory, iBudgetAmount, "right click")
				[+] else
					[ ] ReportStatus("Verify Edit Yearly budget option from gear menu on Annual View selected." , FAIL, "Edit Yearly Budget option from gear menu on Annual View couldn't be selected.")
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify System date and Month displayed on Budget.", FAIL, "System date: {sExpectedCurrentMonth} and actual Month on Budget: {sCurrentMonth} displayed on Quicken->Planning tab didn't match.")
				[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.")  
	[ ] 
[ ] // 
[ ] // 
[+] // //##########Test 10 A: Verify that User should be able to calculate an average monthly budget value using gear menu from Graph View. #####################
	[ ] // // ********************************************************
	[+] // // TestCase Name:	 Test10A_VerifyThatUserShouldBeAbleToToCalculateAverageMonthlyBudgetUsingGearMenuFromGraphView
		[ ] // //
		[ ] // // DESCRIPTION:
		[ ] // // This testcase will Test 9: Verify that User should be able to calculate an average monthly budget value using gear menu from Graph View
		[ ] // //
		[ ] // // PARAMETERS:		None
		[ ] // //
		[ ] // // RETURNS:			Pass 		If User is able to calculate an average monthly budget value using gear menu from Graph View
		[ ] // //						Fail		      If any error occurs
		[ ] // //
		[ ] // // REVISION HISTORY:
		[ ] // // Mukesh created  April 18 2014
		[ ] // ///Note : TestCase not availble in updated sheet
	[ ] // // ********************************************************
[ ] // 
[+] // testcase Test10A_VerifyThatUserShouldBeAbleToToCalculateAverageMonthlyBudgetUsingGearMenuFromGraphView() appstate none
	[ ] // 
	[ ] // //--------------Variable Declaration-------------
	[+] // 
		[ ] // STRING sMonth,sCurrentMonth,sCurrentYear,sActualMonth,sExpectedMonth,sExpectedCurrentMonth,sExpectedAmount,sActualAmount
		[ ] // INTEGER  iMonth ,iMonthDifference, iBackTraversal ,iForwardTraversal
		[ ] // bMatch=FALSE
		[ ] // 
		[ ] // lsExcelData=NULL
		[ ] // lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] // lsCategoryList = lsExcelData[1]
		[ ] // sCategoryType =lsCategoryList[1]
		[ ] // sCategory=lsCategoryList[3]
		[ ] // iBudgetAmount=50
		[ ] // sAmount="0 left"
		[ ] // iForwardTraversal=11
		[ ] // sCurrentMonth=FormatDateTime(GetDateTime(), "mmmm") //Get current month as January 2014
		[ ] // sCurrentYear=FormatDateTime(GetDateTime(),"yyyy")
		[ ] // sExpectedCurrentMonth=sCurrentMonth+" "+sCurrentYear
		[ ] // 
		[ ] // 
		[ ] // 
	[+] // if(QuickenWindow.Exists(5))
		[ ] // QuickenWindow.SetActive()
		[ ] // 
		[ ] // iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
		[+] // if (iResult==PASS)
			[ ] // sleep(2)
			[ ] // QuickenWindow.SetActive()
			[ ] // 
			[ ] // ////Select Graph View of budget
			[ ] // MDIClient.Budget.BudgetViewTypeComboBox.Select(sGraphView)
			[ ] // 
			[ ] // 
			[ ] // sleep(2)
			[ ] // QuickenWindow.SetActive()
			[ ] // sCurrentMonth=MDIClient.Budget.CurrentMonthStaticText.GetText()
			[ ] // 
			[+] // if(sCurrentMonth==sExpectedCurrentMonth)
				[ ] // ReportStatus("Verify System date and Month displayed on Budget.",PASS, "System date and Month displayed on Quicken->Planning tab issame as: {sCurrentMonth}.")
				[ ] // QuickenWindow.SetActive()
				[ ] // 
				[ ] // ///Verify gear menu options on Garph View
				[ ] // // ////Verify "Calculte Average Budget" option from "gear" menu on Graph View
				[ ] // //In below function clicking on the "0 left" string associated with the first subcategory of the list
				[ ] // iResult=SelectDeselectGearMenuOptions(sCategory,sCalculateAverageBudget)
				[+] // if (iResult==PASS)
					[ ] // 
					[ ] // //Edit 12 months average budget
					[ ] // VerifyAverageBudgetValueOnGraphViewAndAnnualView(sCategory, iBudgetAmount, "Gear Menu")
				[+] // else
					[ ] // ReportStatus("Verify claculate average budget option from gear menu on Graph View selected." , FAIL, "Calculate Average Budget option from gear menu on Graph View couldn't be selected on Graph View.")
				[ ] // 
				[ ] // 
				[ ] // 
			[+] // else
				[ ] // ReportStatus("Verify System date and Month displayed on Budget.", FAIL, "System date: {sExpectedCurrentMonth} and actual Month on Budget: {sCurrentMonth} displayed on Quicken->Planning tab didn't match.")
				[ ] // 
		[+] // else
			[ ] // ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
		[ ] // 
	[+] // else
		[ ] // ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.")  
	[ ] // 
[ ] // 
[+] // //##########Test 10 B: Verify that User should be able to calculate an average monthly budget value using right click from Graph View. #####################
	[ ] // // ********************************************************
	[+] // // TestCase Name:	 Test10B_VerifyThatUserShouldBeAbleToToCalculateAverageMonthlyBudgetUsingRightClickFromGraphView
		[ ] // //
		[ ] // // DESCRIPTION:
		[ ] // // This testcase will Test 9: Verify that User should be able to calculate an average monthly budget value using right click from Graph View
		[ ] // //
		[ ] // // PARAMETERS:		None
		[ ] // //
		[ ] // // RETURNS:			Pass 		If User is able to calculate an average monthly budget value using right click from Graph View
		[ ] // //						Fail		      If any error occurs
		[ ] // //
		[ ] // // REVISION HISTORY:
		[ ] // // Mukesh created  April 18 2014
		[ ] // //
	[ ] // // ********************************************************
[ ] // 
[+] // testcase Test10B_VerifyThatUserShouldBeAbleToToCalculateAverageMonthlyBudgetUsingRightClickFromGraphView() appstate none
	[ ] // 
	[ ] // //--------------Variable Declaration-------------
	[+] // 
		[ ] // STRING sMonth,sCurrentMonth,sCurrentYear,sActualMonth,sExpectedMonth,sExpectedCurrentMonth,sExpectedAmount,sActualAmount
		[ ] // INTEGER  iMonth ,iMonthDifference, iBackTraversal ,iForwardTraversal
		[ ] // bMatch=FALSE
		[ ] // 
		[ ] // lsExcelData=NULL
		[ ] // lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] // lsCategoryList = lsExcelData[1]
		[ ] // sCategoryType =lsCategoryList[1]
		[ ] // sCategory=lsCategoryList[3]
		[ ] // iBudgetAmount=50
		[ ] // sAmount="0 left"
		[ ] // iForwardTraversal=11
		[ ] // sCurrentMonth=FormatDateTime(GetDateTime(), "mmmm") //Get current month as January 2014
		[ ] // sCurrentYear=FormatDateTime(GetDateTime(),"yyyy")
		[ ] // sExpectedCurrentMonth=sCurrentMonth+" "+sCurrentYear
		[ ] // 
		[ ] // 
		[ ] // 
	[+] // if(QuickenWindow.Exists(5))
		[ ] // QuickenWindow.SetActive()
		[ ] // 
		[ ] // iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
		[+] // if (iResult==PASS)
			[ ] // sleep(2)
			[ ] // QuickenWindow.SetActive()
			[ ] // 
			[ ] // ////Select Graph View of budget
			[ ] // MDIClient.Budget.BudgetViewTypeComboBox.Select(sGraphView)
			[ ] // 
			[ ] // 
			[ ] // sleep(2)
			[ ] // QuickenWindow.SetActive()
			[ ] // sCurrentMonth=MDIClient.Budget.CurrentMonthStaticText.GetText()
			[ ] // 
			[+] // if(sCurrentMonth==sExpectedCurrentMonth)
				[ ] // ReportStatus("Verify System date and Month displayed on Budget.",PASS, "System date and Month displayed on Quicken->Planning tab issame as: {sCurrentMonth}.")
				[ ] // QuickenWindow.SetActive()
				[ ] // 
				[ ] // ///Verify gear menu options on Garph View
				[ ] // // ////Verify "Calculte Average Budget" option from right click on Graph View
				[ ] // iResult=SelectRightClickCategoryOptions(sCategory , sCalculateAverageBudget)
				[+] // if (iResult==PASS)
					[ ] // 
					[ ] // //Edit 12 months average budget
					[ ] // VerifyAverageBudgetValueOnGraphViewAndAnnualView(sCategory, iBudgetAmount, "right click")
				[+] // else
					[ ] // ReportStatus("Verify claculate average budget option from gear menu on Graph View selected." , FAIL, "Calculate Average Budget option from gear menu on Graph View couldn't be selected on Graph View.")
				[ ] // 
				[ ] // 
				[ ] // 
			[+] // else
				[ ] // ReportStatus("Verify System date and Month displayed on Budget.", FAIL, "System date: {sExpectedCurrentMonth} and actual Month on Budget: {sCurrentMonth} displayed on Quicken->Planning tab didn't match.")
				[ ] // 
		[+] // else
			[ ] // ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
		[ ] // 
	[+] // else
		[ ] // ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.")  
	[ ] // 
[ ] // Quicken crashes  in Test 10 C
[+] // //##########Test 10 C: Verify that User should be able to calculate an average monthly budget value using gear menu from Annual View. #####################
	[ ] // // ********************************************************
	[+] // // TestCase Name:	 Test10C_VerifyThatUserShouldBeAbleToToCalculateAverageMonthlyBudgetUsingGearMenuFromAnnualView
		[ ] // //
		[ ] // // DESCRIPTION:
		[ ] // // This testcase will Test 9: Verify that User should be able to calculate an average monthly budget value using gear menu from Annual View
		[ ] // //
		[ ] // // PARAMETERS:		None
		[ ] // //
		[ ] // // RETURNS:			Pass 		If User is able to calculate an average monthly budget value using gear menu from Annual View
		[ ] // //						Fail		      If any error occurs
		[ ] // //
		[ ] // // REVISION HISTORY:
		[ ] // // Mukesh created  April 18 2014
		[ ] // //
	[ ] // // ********************************************************
[ ] // 
[+] // testcase Test10C_VerifyThatUserShouldBeAbleToToCalculateAverageMonthlyBudgetUsingGearMenuFromAnnualView() appstate none
	[ ] // 
	[ ] // //--------------Variable Declaration-------------
	[+] // 
		[ ] // STRING sMonth,sCurrentMonth,sCurrentYear,sActualMonth,sExpectedMonth,sExpectedCurrentMonth,sExpectedAmount,sActualAmount
		[ ] // INTEGER  iMonth ,iMonthDifference, iBackTraversal ,iForwardTraversal
		[ ] // bMatch=FALSE
		[ ] // 
		[ ] // lsExcelData=NULL
		[ ] // lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] // lsCategoryList = lsExcelData[1]
		[ ] // sCategoryType =lsCategoryList[1]
		[ ] // sCategory=lsCategoryList[3]
		[ ] // iBudgetAmount=50
		[ ] // sAmount="0 left"
		[ ] // iForwardTraversal=11
		[ ] // sCurrentMonth=FormatDateTime(GetDateTime(), "mmmm") //Get current month as January 2014
		[ ] // sCurrentYear=FormatDateTime(GetDateTime(),"yyyy")
		[ ] // sExpectedCurrentMonth=sCurrentMonth+" "+sCurrentYear
		[ ] // 
		[ ] // 
		[ ] // 
	[+] // if(QuickenWindow.Exists(5))
		[ ] // QuickenWindow.SetActive()
		[ ] // 
		[ ] // iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
		[+] // if (iResult==PASS)
			[ ] // sleep(2)
			[ ] // QuickenWindow.SetActive()
			[ ] // 
			[ ] // ////Select Graph View of budget
			[ ] // MDIClient.Budget.BudgetViewTypeComboBox.Select(sGraphView)
			[ ] // 
			[ ] // 
			[ ] // sleep(2)
			[ ] // QuickenWindow.SetActive()
			[ ] // sCurrentMonth=MDIClient.Budget.CurrentMonthStaticText.GetText()
			[ ] // 
			[+] // if(sCurrentMonth==sExpectedCurrentMonth)
				[ ] // ReportStatus("Verify System date and Month displayed on Budget.",PASS, "System date and Month displayed on Quicken->Planning tab issame as: {sCurrentMonth}.")
				[ ] // QuickenWindow.SetActive()
				[ ] // QuickenWindow.SetActive()
				[ ] // ////Select Annual View of budget
				[ ] // MDIClient.Budget.BudgetViewTypeComboBox.Select(sAnnualView)
				[ ] // sleep(4)
				[ ] // ///Verify gear menu options on Annual View
				[ ] // // ////Verify "Calculate Avearge Budget" option from "gear" menu on Annual View
				[ ] // iResult=SelectDeselectGearMenuOptionsAnnualView(sCategory , sCalculateAverageBudget)
				[+] // if (iResult==PASS)
					[ ] // 
					[ ] // //Edit 12 months average budget
					[ ] // VerifyAverageBudgetValueOnGraphViewAndAnnualView(sCategory, iBudgetAmount, "Gear Menu")
				[+] // else
					[ ] // ReportStatus("Verify claculate average budget option from gear menu on Annual View selected." , FAIL, "Calculate Average Budget option from gear menu on Annual View couldn't be selected.")
				[ ] // 
				[ ] // 
				[ ] // 
				[ ] // 
			[+] // else
				[ ] // ReportStatus("Verify System date and Month displayed on Budget.", FAIL, "System date: {sExpectedCurrentMonth} and actual Month on Budget: {sCurrentMonth} displayed on Quicken->Planning tab didn't match.")
				[ ] // 
		[+] // else
			[ ] // ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
		[ ] // 
	[+] // else
		[ ] // ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.")  
	[ ] // 
[ ] // // 
[+] // //##########Test 10 D: Verify that User should be able to calculate an average monthly budget value using right click from Annual View. #####################
	[ ] // // ********************************************************
	[+] // // TestCase Name:	 Test10D_VerifyThatUserShouldBeAbleToToCalculateAverageMonthlyBudgetUsingRightClickFromAnnualView
		[ ] // //
		[ ] // // DESCRIPTION:
		[ ] // // This testcase will Test 9: Verify that User should be able to calculate an average monthly budget value using right click from Annual View
		[ ] // //
		[ ] // // PARAMETERS:		None
		[ ] // //
		[ ] // // RETURNS:			Pass 		If User is able to calculate an average monthly budget value using right click from Annual View
		[ ] // //						Fail		      If any error occurs
		[ ] // //
		[ ] // // REVISION HISTORY:
		[ ] // // Mukesh created  April 18 2014
		[ ] // //
	[ ] // // ********************************************************
[ ] // 
[+] // testcase Test10D_VerifyThatUserShouldBeAbleToToCalculateAverageMonthlyBudgetUsingRightClickFromAnnualView() appstate none
	[ ] // 
	[ ] // //--------------Variable Declaration-------------
	[+] // 
		[ ] // STRING sMonth,sCurrentMonth,sCurrentYear,sActualMonth,sExpectedMonth,sExpectedCurrentMonth,sExpectedAmount,sActualAmount
		[ ] // INTEGER  iMonth ,iMonthDifference, iBackTraversal ,iForwardTraversal
		[ ] // bMatch=FALSE
		[ ] // 
		[ ] // lsExcelData=NULL
		[ ] // lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] // lsCategoryList = lsExcelData[1]
		[ ] // sCategoryType =lsCategoryList[1]
		[ ] // sCategory=lsCategoryList[3]
		[ ] // iBudgetAmount=50
		[ ] // sAmount="0 left"
		[ ] // iForwardTraversal=11
		[ ] // sCurrentMonth=FormatDateTime(GetDateTime(), "mmmm") //Get current month as January 2014
		[ ] // sCurrentYear=FormatDateTime(GetDateTime(),"yyyy")
		[ ] // sExpectedCurrentMonth=sCurrentMonth+" "+sCurrentYear
		[ ] // 
		[ ] // 
		[ ] // 
	[+] // if(QuickenWindow.Exists(5))
		[ ] // QuickenWindow.SetActive()
		[ ] // 
		[ ] // iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
		[+] // if (iResult==PASS)
			[ ] // sleep(2)
			[ ] // QuickenWindow.SetActive()
			[ ] // 
			[ ] // ////Select Graph View of budget
			[ ] // MDIClient.Budget.BudgetViewTypeComboBox.Select(sGraphView)
			[ ] // 
			[ ] // 
			[ ] // sleep(2)
			[ ] // QuickenWindow.SetActive()
			[ ] // sCurrentMonth=MDIClient.Budget.CurrentMonthStaticText.GetText()
			[ ] // 
			[+] // if(sCurrentMonth==sExpectedCurrentMonth)
				[ ] // ReportStatus("Verify System date and Month displayed on Budget.",PASS, "System date and Month displayed on Quicken->Planning tab issame as: {sCurrentMonth}.")
				[ ] // QuickenWindow.SetActive()
				[ ] // ////Select Annual View of budget
				[ ] // MDIClient.Budget.BudgetViewTypeComboBox.Select(sAnnualView)
				[ ] // 
				[ ] // ///Verify gear menu options on Garph View
				[ ] // // ////Verify "Calculte Average Budget" option from right click on Graph View
				[ ] // iResult=SelectRightClickCategoryOptions(sCategory , sCalculateAverageBudget)
				[ ] // 
				[+] // if (iResult==PASS)
					[ ] // 
					[ ] // //Veridy 12 months average budget
					[ ] // VerifyAverageBudgetValueOnGraphViewAndAnnualView(sCategory, iBudgetAmount, "right click")
				[+] // else
					[ ] // ReportStatus("Verify claculate average budget option from gear menu on Annual View selected." , FAIL, "Calculate Average Budget option from gear menu on Annual View couldn't be selected.")
				[ ] // 
				[ ] // 
				[ ] // 
			[+] // else
				[ ] // ReportStatus("Verify System date and Month displayed on Budget.", FAIL, "System date: {sExpectedCurrentMonth} and actual Month on Budget: {sCurrentMonth} displayed on Quicken->Planning tab didn't match.")
				[ ] // 
		[+] // else
			[ ] // ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
		[ ] // 
	[+] // else
		[ ] // ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.")  
	[ ] // 
[ ] // 
[ ] 
[+] //##########Test 11: Verify that when  extending an existing budget for additional year, User would like the option to base the default budget values on the previous year's actual spending within a category. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test11_VerifyThatUserShouldBeAbleToBaseTheDefaultBudgetValuesOnPreviousYearsBudgetWhileExtendingToNextYear
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that when extending an existing budget for additional year, User would like the option to base the default budget values on the previous year's actual spending within a category
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If User is able to extend the budget for next based on the current year budget
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  April 21 2014
		[ ] ///Note : TestCase not availble in updated sheet
	[ ] // ********************************************************
[ ] 
[+] testcase Test11_VerifyThatUserShouldBeAbleToBaseTheDefaultBudgetValuesOnPreviousYearsBudgetWhileExtendingToNextYear() appstate QuickenBaseState
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] 
		[ ] STRING sMonth,sCurrentMonth,sCurrentYear,sActualMonth,sExpectedMonth,sExpectedCurrentMonth,sExpectedAmount,sActualAmount
		[ ] STRING sYear , sDay , sTxnAmount
		[ ] INTEGER  iMonth ,iMonthDifference, iBackTraversal ,iForwardTraversal ,iDay ,iTxnAmount
		[ ] bMatch=FALSE
		[ ] sOption="right click"
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] lsCategoryList = lsExcelData[1]
		[ ] sCategoryType =lsCategoryList[1]
		[ ] sCategory=lsCategoryList[3]
		[ ] iBudgetAmount=50
		[ ] sAmount="0 left"
		[ ] 
		[ ] 
		[ ] sCurrentMonth=FormatDateTime(GetDateTime(), "m") //Get current month as January 2014
		[ ] iCurrentMonth=VAL(sCurrentMonth)
		[+] if (iCurrentMonth<5)
			[ ] iTxnMonths =iCurrentMonth
		[+] else
			[ ] iTxnMonths=4
		[ ] 
		[ ] sCurrentMonth=FormatDateTime(GetDateTime(), "mmmm") //Get current month as January 2014
		[ ] sCurrentYear=FormatDateTime(GetDateTime(),"yyyy")
		[ ] sExpectedCurrentMonth=sCurrentMonth+" "+sCurrentYear
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] sAccountName= lsAddAccount[2]
		[ ] // Fetch 1st row from sRegTransactionSheet the given sheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sRegTransactionSheet)
		[ ] lsTransaction=lsExcelData[1]
		[ ] iTxnAmount=VAL(lsTransaction[3])
		[ ] sTxnAmount=str(iTxnAmount)
		[ ] iMonthCount=VAL(GetPreviousMonth(3))
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //Select account
		[ ] iResult= SelectAccountFromAccountBar(sAccountName, ACCOUNT_BANKING)
		[+] if (iResult==PASS)
			[ ] ///Add last three months and current month transaction
			[+] for (iCount=3 ; iCount>=0; iCount--)
				[ ] QuickenWindow.SetActive()
				[ ] sDate=GetPreviousMonth(iCount)
				[ ] AddCheckingTransaction(lsTransaction[1],lsTransaction[2],lsTransaction[3],sDate,lsTransaction[5],lsTransaction[6],lsTransaction[7],lsTransaction[8])
				[ ] 
			[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
			[+] if (iResult==PASS)
				[ ] sleep(2)
				[ ] QuickenWindow.SetActive()
				[ ] 
				[ ] ////Select Annual View of budget
				[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sGraphView)
				[ ] iResult=AddAverageBudget(sCategory ,iBudgetAmount)
				[+] if (iResult==PASS)
					[ ] QuickenWindow.SetActive()
					[ ] ///Navigate to extend current budget for the next year
					[ ] QuickenWindow.SetActive()
					[ ] 
					[+] while (!DlgAddABudgetForNextOrPreviousYear.Exists())
						[ ] MDIClient.Budget.ForwardMonthButton.Click()
						[ ] 
						[ ] ///Extend budget for next year using second option
					[+] if (DlgAddABudgetForNextOrPreviousYear.Exists(5))
						[ ] DlgAddABudgetForNextOrPreviousYear.SetActive()
						[ ] sActual =DlgAddABudgetForNextOrPreviousYear.GetProperty("Caption")
						[ ] DlgAddABudgetForNextOrPreviousYear.RadioListCopyThisYearsCategoriesAndActualsAsBudget.Select(2)
						[ ] DlgAddABudgetForNextOrPreviousYear.OKButton.Click()
						[ ] 
						[ ] ////Navigate to Annual View
						[ ] 
						[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sAnnualView)
						[ ] sleep(4)
						[ ] MDIClient.Budget.AnnualViewTypeComboBox.Select("Budget only")
						[ ] QuickenWindow.SetActive()
						[ ] ///Prvevious month actual amounts would be considered as budget for the same months of the next year
						[ ] 
						[ ] sTxnExpectedAmount="*{sTxnAmount}*"
						[+] for (iCount=1 ; iCount<iTxnMonths-1;++iCount)
							[ ] sTxnExpectedAmount=sTxnExpectedAmount+"*{sTxnAmount}*"
						[ ] 
						[ ] ///Create the expected budget amounts
						[ ] iBudgetMonths =12 - iCurrentMonth
						[ ] sExpectedAmount="*{iBudgetAmount}*"
						[+] for (iCount=1 ; iCount<=iBudgetMonths;++iCount)
							[ ] sExpectedAmount=sExpectedAmount+"*{iBudgetAmount}*"
						[ ] 
						[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
						[ ] iListCount= MDIClient.Budget.ListBox.GetItemCount() +1
						[ ] 
						[ ] ///Verify that budget has been extended as expected.
						[ ] 
						[+] for (iCount=1 ; iCount<=iListCount;++iCount)
							[ ] BOOLEAN bMatch1
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
							[ ] bMatch = MatchStr("*{sExpectedAmount}*", sActual)
							[ ] bMatch1 = MatchStr("*{sTxnExpectedAmount}*", sActual)
							[+] if (bMatch && bMatch1)
								[ ] break
						[+] if(bMatch)
							[ ] ReportStatus("Verify that User is able to extend the budget for next based on the current year budget." ,PASS, "The Budget has been extended for next year as expected:{sActual} as expected with actual category amount :{sTxnExpectedAmount} and budget amount {sExpectedAmount} for category: {sCategory} on Annual View.")
						[+] else
							[ ] ReportStatus("Verify that User is able to extend the budget for next based on the current year budget." ,FAIL, "The Budget couldn't be extended for next year as actual is: {sActual} against expected with actual category amount :{sTxnExpectedAmount} and budget amount {sExpectedAmount} for category: {sCategory} on Annual View.")
						[ ] 
						[ ] //
						[ ] ClearTheBudgetValuesOnAnnualView(sCategory)
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify the Budget can be extended to next year." , FAIL, "Dialog:{sActual} didn't appear.")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify that User is able to add average budget for category: {sCategory} with amount: {iBudgetAmount}."  , FAIL,"Average budget for category: {sCategory} with amount: {iBudgetAmount} couldn't be added for 12 months on Graph View.")
			[+] else
				[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
		[+] else
			[ ] ReportStatus("Verfiy account: {sAccountName} selected." , FAIL ,"Account: {sAccountName} coulkdn't be selected.")
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.")  
	[ ] 
[ ] 
[+] //##########Test 13: Verify that Category Total "left/over" values on Annual view should include rollover. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test13_VerifyThatThatCategoryTotalBalanceValuesOnAnnualViewShouldIncludeRollOver
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that Category Total "left/over" values on Annual view should include rollover
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Category Total "left/over" values on Annual view should include rollover.
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  April 23 2014
		[ ] ///Note : TestCase not availble in updated sheet
	[ ] // ********************************************************
[ ] 
[+] testcase Test12_13_VerifyThatCategoryTotalBalanceValuesOnAnnualViewShouldIncludeRollOver() appstate none
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] STRING sParentCategoryAmount ,sAmountString ,sExpectedNoTxnRollOverAmount ,sExpectedTxnRollOverAmount
		[ ] INTEGER iCurrentMonth ,iRollOverMonthCount  ,iRollOverWithNoTxnMonthCount ,iTxnMonthCount ,iRollOverWithNoTxnMonthAmount
		[ ] INTEGER iTxnAmount ,iDiffOfBudgetTxnAmount ,iExpectedTxnRollOverAmount
		[ ] sBudgetName = "BudgetTest"
		[ ] bMatch=FALSE
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] iBudgetAmount=50
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] lsCategoryList=lsExcelData[1]
		[ ] sCategory=lsCategoryList[3]
		[ ] // Fetch 1st row from sRegTransactionSheet the given sheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sRegTransactionSheet)
		[ ] lsTransaction=lsExcelData[1]
		[ ] iTxnAmount=VAL(lsTransaction[3])
		[ ] 
		[ ] sAmountString="20 left"
		[ ] sCurrentMonth=FormatDateTime(GetDateTime(), "m") //Get current month as January 2014
		[ ] iCurrentMonth = VAL(sCurrentMonth)
		[ ] iRollOverMonthCount=4
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
		[+] if (iResult==PASS)
			[ ] sleep(2)
			[ ] iResult=DeleteBudget()
			[+] if (iResult==PASS)
				[ ] iResult=AddBudget(sBudgetName)
				[+] if (iResult==PASS)
					[ ] ReportStatus("Verify budget gets added.", PASS, "Budget: {sBudgetName} has been added.")
					[ ] 
					[ ] QuickenWindow.SetActive()
					[ ] 
					[ ] 
					[ ] //// Set Parent rollup on
					[ ] SelectBudgetOptionOnGraphAnnualView(sGraphView,"Rollup")
					[ ] sleep(2)
					[ ] iResult=AddAverageBudget(sCategory ,iBudgetAmount)
					[+] if (iResult==PASS)
						[ ] QuickenWindow.SetActive()
						[ ] ///Enable Rollover 
						[ ] SelectDeselectRollOverOptions (sCategory, sSetRollOverBalance,FALSE)
						[ ] QuickenWindow.SetActive()
						[ ] ////Select annual view on budget
						[ ] lsRolloverData = CreateRollOverData(  sCategory, iBudgetAmount ,  iTxnAmount)
						[ ] sExpectedNoTxnRollOverAmount =lsRolloverData[2]
						[ ] sExpectedTxnRollOverAmount =lsRolloverData[3]
						[ ] iCatTotalRolloverAmount=lsRolloverData[1]
						[ ] 
						[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sAnnualView)
						[ ] sleep(4)
						[ ] QuickenWindow.SetActive()
						[ ] MDIClient.Budget.AnnualViewTypeComboBox.Select("Balance only")
						[ ] sleep(2)
						[ ] QuickenWindow.SetActive()
						[+] if (MDIClient.Budget.ShowBalanceInFutureMonthsCheckBox.Exists(2))
							[ ] MDIClient.Budget.ShowBalanceInFutureMonthsCheckBox.Check()
							[ ] 
						[ ] 
						[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
						[ ] iListCount= MDIClient.Budget.ListBox.GetItemCount() +1
						[+] for (iCount=2 ; iCount<=iListCount;++iCount)
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
							[ ] bMatch = MatchStr("*{sExpectedNoTxnRollOverAmount}*{sExpectedTxnRollOverAmount}*{iCatTotalRolloverAmount}*", sActual)
							[+] if (bMatch)
								[ ] break
						[+] if(bMatch)
							[ ] ReportStatus("Verify that Category Total Balance values on Annual view should include rollover." ,PASS, "The Category Total Balance values on Annual view included rollover for category: {sCategory} on Annual View as expected:{sExpectedNoTxnRollOverAmount}, {sExpectedTxnRollOverAmount},{iCatTotalRolloverAmount}*.")
						[+] else
							[ ] ReportStatus("Verify that Category Total Balance values on Annual view should include rollover." ,FAIL, "The Category Total Balance values on Annual view didn't include the rollover for category: {sCategory} on Annual View as actual: {sActual} is not as expected:{sExpectedNoTxnRollOverAmount}, {sExpectedTxnRollOverAmount},{iCatTotalRolloverAmount}*.")
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify that User is able to add average budget for category: {sCategory} with amount: {iBudgetAmount}."  , FAIL,"Average budget for category: {sCategory} with amount: {iBudgetAmount} couldn't be added for 12 months on Graph View.")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify budget gets added.", FAIL, "Budget: {sBudgetName} couldn't be added.")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify budget gets deleted.", FAIL, "Budget: {sBudgetName} couldn't be deleted.")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
	[ ] 
[ ] 
[+] //##########Test 29: As a user of budgets, I should have options to turn on and off rollover on both the Annual and Graph views #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test29_VerifyCategoryTotalBalanceValuesOnAnnualViewAndLeftOverOnGraphViewAfterSwitchingOffRollOver
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify the Category Total balance on annual view and left over on graph view after switching off the rollover
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If total balance on annual view and left over on graph view is correct after switching off the rollover
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  June 04 2014
		[ ] 
	[ ] // ********************************************************
[ ] 
[+] testcase Test29_VerifyCategoryTotalBalanceValuesOnAnnualViewAndLeftOverOnGraphViewAfterSwitchingOffRollOver() appstate none
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] INTEGER iTxnAmount ,iBalance ,iTotalBalance
		[ ] sBudgetName = "BudgetTest"
		[ ] bMatch=FALSE
		[ ] iBudgetAmount=50
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] lsCategoryList=lsExcelData[1]
		[ ] sCategory=lsCategoryList[3]
		[ ] // Fetch 1st row from sRegTransactionSheet the given sheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sRegTransactionSheet)
		[ ] lsTransaction=lsExcelData[1]
		[ ] iTxnAmount=VAL(lsTransaction[3])
		[ ] 
		[ ] sCurrentMonth=FormatDateTime(GetDateTime(), "m") //Get current month as January 2014
		[ ] iCurrentMonth = VAL(sCurrentMonth)
		[ ] 
		[ ] 
		[ ] //Calculate transaction months
		[ ] iTxnMonths=4
		[+] if (iCurrentMonth<=4)
			[ ] iNoTxnMonths=0
			[ ] 
		[+] else
			[ ] iNoTxnMonths=iCurrentMonth-4
		[ ] //calculate total budget 
		[ ] iTotalBudget =12*iBudgetAmount
		[ ] iTotalExpense= iTxnAmount*iTxnMonths
		[ ] iTotalBalance=iTotalBudget - iTotalExpense
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
		[+] if (iResult==PASS)
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] //Switch off the rollover
			[ ] SelectDeselectRollOverOptions (sCategory ,  sSetRollOverOff )
			[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sAnnualView)
			[ ] sleep(4)
			[ ] QuickenWindow.SetActive()
			[ ] MDIClient.Budget.AnnualViewTypeComboBox.Select("Balance only")
			[ ] sleep(2)
			[ ] ///Prepare balance data when rollover is put off
			[ ] sCategory=trim(lsTransaction[8])
			[ ] sExpectedPattern=""
			[+] for (iCounter=1 ;  iCounter<= iCurrentMonth; iCounter++)
				[+] if(iNoTxnMonths>0)
					[+] if (iCounter<=iNoTxnMonths)
						[ ] iTxnAmount=0
					[+] else
						[ ] iTxnAmount=VAL(lsTransaction[3])
				[+] else
					[ ] iTxnAmount=VAL(lsTransaction[3])
				[ ] ///This is to add reminder amount in the first transaction
				[ ] iBalance=iBudgetAmount-iTxnAmount
				[ ] sExpectedPattern=sExpectedPattern+"*{trim(str(iBalance,4))}*"
			[ ] ///Verify balance amount on details view
			[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
			[ ] iListCount =MDIClient.Budget.ListBox.GetItemCount() 
			[ ] 
			[+] for(iCounter= 1; iCounter <= iListCount;  iCounter++)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCounter))
				[ ] bMatch = MatchStr("*{sExpectedPattern}*{iTotalBalance}*",sActual)
				[+] if (bMatch)
					[ ] break
			[+] if (bMatch)
				[ ] ReportStatus("Verify the Category Total balance after switching off the rollover on Balance Only View.", PASS ,"The category monthly balance is as expected:{sExpectedPattern} and total balance: {iTotalBalance} for {sCategory} after switching off the rollover on Balance Only View.")
			[+] else
				[ ] ReportStatus("Verify the Category Total balance after switching off the rollover on Balance Only View.", FAIL ,"The category monthly balance is NOT as expected:{sExpectedPattern} and total balance: {iTotalBalance} for {sCategory} after switching off the rollover on Balance Only View.")
				[ ] 
			[ ] 
			[ ] ///Verify left over on graph view after switching off roll over
			[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sGraphView)
			[ ] MDIClient.Budget.BudgetDurationComboBox.Select("Yearly")
			[ ] MDIClient.Budget.BudgetDurationComboBox.Select("Yearly")
			[ ] MDIClient.Budget.BudgetDurationComboBox.Select("Yearly")
			[ ] sleep(1)
			[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
			[ ] iListCount =MDIClient.Budget.ListBox.GetItemCount() 
			[ ] 
			[+] for(iCounter= 1; iCounter <= iListCount;  iCounter++)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCounter))
				[ ] bMatch = MatchStr("*{sCategory}*{iTotalExpense}*{iTotalBalance}*{iTotalBudget}*",sActual)
				[+] if (bMatch)
					[ ] break
			[+] if (bMatch)
				[ ] ReportStatus("Verify the Category Total balance after switching off the rollover on Graph View.", PASS ,"The total expense:{iTotalExpense}, total left: {iTotalBalance} and total budget: {iTotalBudget} is as expected for category: {sCategory} after switching off the rollover on Graph View.")
			[+] else
				[ ] ReportStatus("Verify the Category Total balance after switching off the rollover on Graph View.", FAIL ,"The expected total expense:{iTotalExpense}, total left: {iTotalBalance} and total budget: {iTotalBudget} is NOT as actual:{sActual} for category: {sCategory} after switching off the rollover on Graph View.")
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
	[ ] 
[ ] 
[ ] 
[+] //##########Test 30: As a user, I want my rollover to be updated when I edit past budget amounts or change rollover options #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test30_VerifyThatRolloverGetsUpdatedWhenBudgetAmountsAreUpdated
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that rollover gets updated when budget amounts are updated
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Category Total "left/over" values on Annual view should include rollover.
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  June 07 2014
		[ ] 
	[ ] // ********************************************************
[ ] 
[+] testcase Test30_VerifyThatRolloverGetsUpdatedWhenBudgetAmountsAreUpdated() appstate none
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] STRING sParentCategoryAmount ,sAmountString ,sExpectedNoTxnRollOverAmount ,sExpectedTxnRollOverAmount
		[ ] INTEGER iCurrentMonth ,iRollOverMonthCount  ,iRollOverWithNoTxnMonthCount ,iTxnMonthCount ,iRollOverWithNoTxnMonthAmount
		[ ] INTEGER iTxnAmount ,iDiffOfBudgetTxnAmount ,iExpectedTxnRollOverAmount
		[ ] sBudgetName = "BudgetTest"
		[ ] bMatch=FALSE
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] iBudgetAmount=50
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] lsCategoryList=lsExcelData[1]
		[ ] sCategory=lsCategoryList[3]
		[ ] 
		[ ] // Fetch 1st row from sRegTransactionSheet the given sheet
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sRegTransactionSheet)
		[ ] lsTransaction=lsExcelData[1]
		[ ] iTxnAmount=VAL(lsTransaction[3])
		[ ] 
		[ ] sAmountString="20 left"
		[ ] sCurrentMonth=FormatDateTime(GetDateTime(), "m") //Get current month as January 2014
		[ ] iCurrentMonth = VAL(sCurrentMonth)
		[ ] iRollOverMonthCount=4
		[ ] 
		[ ] //Calculate transaction months
		[ ] iTxnMonths=4
		[+] if (iCurrentMonth<=4)
			[ ] iNoTxnMonths=0
			[ ] 
		[+] else
			[ ] iNoTxnMonths=iCurrentMonth-4
		[ ] 
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
		[+] if (iResult==PASS)
			[ ] sleep(2)
			[ ] QuickenWindow.SetActive()
			[ ] //Select graph view
			[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sGraphView)
			[ ] //Select monthly view on graph view
			[ ] 
			[ ] MDIClient.Budget.BudgetDurationComboBox.Select("Monthly")
			[ ] MDIClient.Budget.BudgetDurationComboBox.Select("Monthly")
			[ ] 
			[ ] sleep(2)
			[ ] iResult=AddAverageBudget(sCategory ,iBudgetAmount)
			[+] if (iResult==PASS)
				[ ] QuickenWindow.SetActive()
				[ ] ///Enable Rollover 
				[ ] SelectDeselectRollOverOptions (sCategory, sSetRollOverBalance)
				[ ] QuickenWindow.SetActive()
				[ ] ////Select annual view on budget
				[ ] lsRolloverData = CreateRollOverData(  sCategory, iBudgetAmount ,  iTxnAmount)
				[ ] sExpectedNoTxnRollOverAmount =lsRolloverData[2]
				[ ] sExpectedTxnRollOverAmount =lsRolloverData[3]
				[ ] iCatTotalRolloverAmount=lsRolloverData[1]
				[ ] 
				[ ] 
				[ ] sleep(4)
				[ ] QuickenWindow.SetActive()
				[ ] //Select annual view
				[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sAnnualView)
				[ ] sleep(2)
				[ ] MDIClient.Budget.AnnualViewTypeComboBox.Select("Balance only")
				[ ] sleep(2)
				[ ] QuickenWindow.SetActive()
				[+] if (MDIClient.Budget.ShowBalanceInFutureMonthsCheckBox.Exists(2))
					[ ] MDIClient.Budget.ShowBalanceInFutureMonthsCheckBox.Check()
					[ ] 
				[ ] 
				[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
				[ ] iListCount= MDIClient.Budget.ListBox.GetItemCount() +1
				[+] for (iCount=2 ; iCount<=iListCount;++iCount)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
					[ ] bMatch = MatchStr("*{sExpectedNoTxnRollOverAmount}*{sExpectedTxnRollOverAmount}*{iCatTotalRolloverAmount}*", sActual)
					[+] if (bMatch)
						[ ] break
				[+] if(bMatch)
					[ ] ReportStatus("Verify that Category Total Balance values on Annual view should include rollover." ,PASS, "The Category Total Balance values on Annual view included rollover for category: {sCategory} on Annual View as expected:{sExpectedNoTxnRollOverAmount}, {sExpectedTxnRollOverAmount},{iCatTotalRolloverAmount}*.")
				[+] else
					[ ] ReportStatus("Verify that Category Total Balance values on Annual view should include rollover." ,FAIL, "The Category Total Balance values on Annual view didn't include the rollover for category: {sCategory} on Annual View as actual: {sActual} is not as expected:{sExpectedNoTxnRollOverAmount}, {sExpectedTxnRollOverAmount},{iCatTotalRolloverAmount}*.")
				[ ] 
				[ ] ///Set rollover off on Annual View
				[ ] SelectDeselectRollOverOptions (sCategory ,  sSetRollOverOff , FALSE)
				[ ] //Update budget to 100
				[ ] iBudgetAmount=100
				[ ] //Select details view to update budget
				[ ] MDIClient.Budget.AnnualViewTypeComboBox.Select("Details")
				[ ] iResult=AddAverageBudget(sCategory ,iBudgetAmount)
				[+] if (iResult==PASS)
					[ ] ReportStatus("Verify that user is able to update average budget for category: {sCategory} with amount: {iBudgetAmount}."  , PASS,"Average budget for category: {sCategory} with amount: {iBudgetAmount} has been updated for 12 months on annual View.")
					[ ] //Turn on the  rollover on annual view
					[ ] SelectDeselectRollOverOptions (sCategory, sSetRollOverBalance,FALSE)
					[ ] QuickenWindow.SetActive()
					[ ] ////Create roll over data for the updated budget 
					[ ] lsRolloverData = CreateRollOverData(  sCategory, iBudgetAmount ,  iTxnAmount)
					[ ] sExpectedNoTxnRollOverAmount =lsRolloverData[2]
					[ ] sExpectedTxnRollOverAmount =lsRolloverData[3]
					[ ] iCatTotalRolloverAmount=lsRolloverData[1]
					[ ] 
					[ ] QuickenWindow.SetActive()
					[ ] MDIClient.Budget.AnnualViewTypeComboBox.Select("Balance only")
					[ ] sleep(2)
					[ ] QuickenWindow.SetActive()
					[+] if (MDIClient.Budget.ShowBalanceInFutureMonthsCheckBox.Exists(2))
						[ ] MDIClient.Budget.ShowBalanceInFutureMonthsCheckBox.Check()
						[ ] 
					[ ] 
					[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
					[ ] iListCount= MDIClient.Budget.ListBox.GetItemCount() +1
					[+] for (iCount=2 ; iCount<=iListCount;++iCount)
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
						[ ] bMatch = MatchStr("*{sExpectedNoTxnRollOverAmount}*{sExpectedTxnRollOverAmount}*{iCatTotalRolloverAmount}*", StrTran(sActual, ",",""))
						[+] if (bMatch)
							[ ] break
					[+] if(bMatch)
						[ ] ReportStatus("Verify that rollover gets updated when budget amounts are updated on Annual View." ,PASS, "The Category Total Balance values on Annual view included rollover for category: {sCategory} on Annual View as expected:{sExpectedNoTxnRollOverAmount}, {sExpectedTxnRollOverAmount},{iCatTotalRolloverAmount}*.")
					[+] else
						[ ] ReportStatus("Verify that rollover gets updated when budget amounts are updated on Annual View." ,FAIL, "The Category Total Balance values on Annual view didn't include the rollover for category: {sCategory} on Annual View as actual: {sActual} is not as expected:{sExpectedNoTxnRollOverAmount}, {sExpectedTxnRollOverAmount},{iCatTotalRolloverAmount}*.")
					[ ] 
					[ ] 
					[ ] 
					[ ] ///Verify left over on graph view after switching off rollover on Graph View
					[ ] //Calculate total budget 
					[ ] iTotalBudget =12*iBudgetAmount
					[ ] iTotalExpense= iTxnAmount*iTxnMonths
					[ ] iTotalBalance=iTotalBudget - iTotalExpense
					[ ] 
					[ ] 
					[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sGraphView)
					[ ] sleep(2)
					[ ] MDIClient.Budget.BudgetDurationComboBox.Select("Yearly")
					[ ] MDIClient.Budget.BudgetDurationComboBox.Select("Yearly")
					[ ] MDIClient.Budget.BudgetDurationComboBox.Select("Yearly")
					[ ] sleep(1)
					[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
					[ ] iListCount =MDIClient.Budget.ListBox.GetItemCount() 
					[ ] 
					[+] for(iCounter= 1; iCounter <= iListCount;  iCounter++)
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCounter))
						[ ] bMatch = MatchStr("*{sCategory}*{iTotalExpense}*{iTotalBalance}*{iTotalBudget}*",StrTran(sActual, ",",""))
						[+] if (bMatch)
							[ ] break
					[+] if (bMatch)
						[ ] ReportStatus("Verify that rollover gets updated when budget amounts are updated on Graph View.", PASS ,"The total expense:{iTotalExpense}, total left: {iTotalBalance} and total budget: {iTotalBudget} is as expected for category: {sCategory} after switching off the rollover on Graph View.")
					[+] else
						[ ] ReportStatus("Verify that rollover gets updated when budget amounts are updated on Graph View.", FAIL ,"The expected total expense:{iTotalExpense}, total left: {iTotalBalance} and total budget: {iTotalBudget} is NOT as actual:{sActual} for category: {sCategory} after switching off the rollover on Graph View.")
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify that user is able to update average budget for category: {sCategory} with amount: {iBudgetAmount}."  , FAIL,"Average budget for category: {sCategory} with amount: {iBudgetAmount} couldn't be updated for 12 months on annual View.")
					[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify that User is able to add average budget for category: {sCategory} with amount: {iBudgetAmount}."  , FAIL,"Average budget for category: {sCategory} with amount: {iBudgetAmount} couldn't be added for 12 months on Graph View.")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
	[ ] 
[ ] 
[ ] 
[ ] 
[+] //##########Test 6:Verify that Everything Else item should support rollover. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test6_VerifyThatEverytingElseItemShouldSupportRollOver
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that Everything Else item supports rollover
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Everything Else item supports rollover
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  April 23 2014
		[ ] ///Note : TestCase not availble in updated sheet
	[ ] // ********************************************************
[ ] 
[+] testcase Test6_VerifyThatEverytingElseItemShouldSupportRollOver() appstate none
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] STRING sParentCategoryAmount ,sAmountString ,sExpectedNoTxnRollOverAmount ,sExpectedTxnRollOverAmount
		[ ] INTEGER iCurrentMonth ,iRollOverMonthCount  ,iRollOverWithNoTxnMonthCount ,iTxnMonthCount ,iRollOverWithNoTxnMonthAmount
		[ ] INTEGER iTxnAmount ,iDiffOfBudgetTxnAmount ,iExpectedTxnRollOverAmount
		[ ] sBudgetName = "BudgetTest"
		[ ] bMatch=FALSE
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] iBudgetAmount=50
		[ ] // Fetch 1st row from sRegTransactionSheet the given sheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sRegTransactionSheet)
		[ ] lsTransaction=lsExcelData[1]
		[ ] iTxnAmount=VAL(lsTransaction[3])
		[ ] 
		[ ] sAmountString="30 over"
		[ ] sCurrentMonth=FormatDateTime(GetDateTime(), "m") //Get current month as January 2014
		[ ] iCurrentMonth = VAL(sCurrentMonth)
		[ ] iRollOverMonthCount=4
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] lsCategoryList=lsExcelData[1]
		[ ] sCategory=lsCategoryList[3]
		[ ] 
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
		[+] if (iResult==PASS)
			[ ] sleep(2)
			[ ] iResult=DeleteBudget()
			[+] if (iResult==PASS)
				[ ] iResult=AddBudget(sBudgetName)
				[+] if (iResult==PASS)
					[ ] ReportStatus("Verify budget gets added.", PASS, "Budget: {sBudgetName} has been added.")
					[ ] 
					[ ] QuickenWindow.SetActive()
					[ ] 
					[ ] 
					[ ] //// Set Parent rollup on
					[ ] SelectBudgetOptionOnGraphAnnualView(sGraphView,"Rollup")
					[ ] sleep(2)
					[ ] 
					[ ] 
					[ ] ///Add Auto & transport parent and few sub categoriesto budget
					[ ] lsCategoryList = lsExcelData[1]
					[ ] sCategoryType =lsCategoryList[1]
					[ ] ListDelete (lsCategoryList ,1)
					[ ] iResult=AddCategoriesToBudget(sCategoryType , lsCategoryList)
					[+] if (iResult==PASS)
						[ ] ReportStatus("Verify categories added to the budget.", PASS , "Categories: {lsCategoryList} of type: {sCategoryType} added to the budget.") 
						[ ] bMatch=TRUE
					[+] else
						[ ] ReportStatus("Verify categories added to the budget.", FAIL , "Categories: {lsCategoryList} of type: {sCategoryType} couldn't be added to the budget.") 
						[ ] bMatch=FALSE
					[+] if(bMatch)
						[ ] QuickenWindow.SetActive()
						[ ] iResult=AddAverageBudget(sEverythingElse ,iBudgetAmount)
						[+] if (iResult==PASS)
							[ ] QuickenWindow.SetActive()
							[ ] ///Enable Rollover 
							[ ] SelectDeselectRollOverOptions (sEverythingElse, sSetRollOverBalance)
							[ ] QuickenWindow.SetActive()
							[ ] 
							[ ] iTxnMonthCount=4
							[ ] iRollOverWithNoTxnMonthAmount=0
							[ ] 
							[+] if (iCurrentMonth>4)
								[ ] iRollOverWithNoTxnMonthCount=iCurrentMonth-4
								[ ] 
							[+] else
								[ ] iTxnMonthCount= iCurrentMonth
								[ ] iRollOverWithNoTxnMonthCount=0
								[ ] 
							[ ] 
							[+] if (iTxnMonthCount>1)
								[ ] 
								[ ] ///Get rollover amounts for months for whom there are no transactions
								[+] if (iRollOverWithNoTxnMonthCount > 0)
									[ ] sExpectedNoTxnRollOverAmount="*{iBudgetAmount}*"
									[+] for (iCount=2; iCount<=iRollOverWithNoTxnMonthCount; iCount++)
										[ ] sExpectedNoTxnRollOverAmount =sExpectedNoTxnRollOverAmount +"*{iBudgetAmount*iCount}*"
										[ ] 
										[ ] 
									[ ] ///This amount would be needed to add to the amount of first month with transactions
									[ ] iRollOverWithNoTxnMonthAmount=(iBudgetAmount)*(iCount-1)
								[+] else
									[ ] sExpectedNoTxnRollOverAmount=""
								[ ] 
								[ ] ///Get rollover amounts for months for whom there are  transactions
								[ ] // if (iBudgetAmount > iTxnAmount)
								[ ] iDiffOfBudgetTxnAmount=iBudgetAmount-iTxnAmount
								[+] // else if  (iBudgetAmount < iTxnAmount)
									[ ] // iDiffOfBudgetTxnAmount=iTxnAmount-iBudgetAmount
								[+] // else 
									[ ] // iDiffOfBudgetTxnAmount=iTxnAmount-iBudgetAmount
								[ ] 
								[ ] 
								[ ] iExpectedTxnRollOverAmount=iRollOverWithNoTxnMonthAmount+iDiffOfBudgetTxnAmount
								[ ] sExpectedTxnRollOverAmount="*{str(iExpectedTxnRollOverAmount)}*"
								[+] for (iCount=2; iCount<iTxnMonthCount; iCount++)
									[ ] 
									[ ] iExpectedTxnRollOverAmount=iExpectedTxnRollOverAmount + iDiffOfBudgetTxnAmount
									[ ] sExpectedTxnRollOverAmount =sExpectedTxnRollOverAmount +"*{iExpectedTxnRollOverAmount}*"
									[ ] 
									[ ] 
									[ ] 
							[+] else
								[ ] sExpectedNoTxnRollOverAmount="0"
								[ ] sExpectedTxnRollOverAmount="0"
							[ ] ////Select annual view on budget
							[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sAnnualView)
							[ ] sleep(4)
							[ ] QuickenWindow.SetActive()
							[ ] MDIClient.Budget.AnnualViewTypeComboBox.Select("Balance only")
							[ ] sleep(2)
							[ ] 
							[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
							[ ] iListCount= MDIClient.Budget.ListBox.GetItemCount() +1
							[+] for (iCount=1 ; iCount<=iListCount;++iCount)
								[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
								[ ] bMatch = MatchStr("*{sExpectedNoTxnRollOverAmount}*{sExpectedTxnRollOverAmount}*", sActual)
								[+] if (bMatch)
									[ ] break
							[+] if(bMatch)
								[ ] ReportStatus("Verify that Everything Else item should support rollover." ,PASS, "The Category Total Balance values on Annual view included rollover for Everything Else: {sEverythingElse} on Annual View as expected:{sExpectedNoTxnRollOverAmount}, {sExpectedTxnRollOverAmount}.")
							[+] else
								[ ] ReportStatus("Verify that Everything Else item should support rollover." ,FAIL, "The Category Total Balance values on Annual view didn't include the rollover for Everything Else: {sEverythingElse} on Annual View as actual: {sActual} is not as expected:{sExpectedNoTxnRollOverAmount}, {sExpectedTxnRollOverAmount}.")
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify that User is able to add average budget for category: {sCategory} with amount: {iBudgetAmount}."  , FAIL,"Average budget for category: {sCategory} with amount: {iBudgetAmount} couldn't be added for 12 months on Graph View.")
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify categories added to the budget.", FAIL , "Categories couldn't be added to the budget hence testcase can not proceed.") 
						[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify budget gets added.", FAIL, "Budget: {sBudgetName} couldn't be added.")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify budget gets deleted.", FAIL, "Budget: {sBudgetName} couldn't be deleted.")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
	[ ] 
[ ] 
[+] // ##########Test 14 :Verify that Group Balance values on Annual view should include rollover #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test14_16_VerifyThatCategoryGroupBalanceValuesOnAnnualViewShouldIncludeRollOver
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that Group Balance values on Annual view should include rollover
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 		If Group Balance values on Annual view should include rollover. 
		[ ] // Fail		      If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  April 25 2014
		[ ] // /Note : TestCase not availble in updated sheet
	[ ] // ********************************************************
[ ] 
[+] testcase Test14_16_VerifyThatCategoryGroupBalanceValuesOnAnnualViewShouldIncludeRollOver() appstate none
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] INTEGER iRollOverMonthCount ,iTotalRolloverAmount,iOccurrence, iCatTotalRolloverAmount, iTotalSpending ,iTotalBudget , iLeftover
		[ ] List of ANYTYPE lsTxnExcelData,lsRolloverData 
		[ ] STRING sExpectedNoTxnRollOverAmount ,sExpectedTxnRollOverAmount
		[ ] bMatch=FALSE
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] sAccountName=lsAddAccount[2]
		[ ] iBudgetAmount=50
		[ ] // Fetch 1st row from sRegTransactionSheet the given sheet
		[ ] lsTxnExcelData=NULL
		[ ] lsTxnExcelData=ReadExcelTable(sBudgetExcelsheet, sRegTransactionSheet)
		[ ] ///Spending for firs
		[ ] lsTransaction=lsExcelData[1]
		[ ] iTxnAmount=VAL(lsTransaction[3])
		[ ] 
		[ ] 
		[ ] sAmountString="0 left"
		[ ] sCurrentMonth=FormatDateTime(GetDateTime(), "m") //Get current month as January 2014
		[ ] iCurrentMonth = VAL(sCurrentMonth)
		[ ] iRollOverMonthCount=4
		[ ] iTotalSpending=0
		[ ] iTotalBudget=0
		[ ] iTotalRolloverAmount=0
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] 
		[ ] ///Remove category type and parent category from the list
		[ ] lsCategoryList = lsExcelData[1]
		[ ] sCategoryType =lsCategoryList[1]
		[ ] ListDelete (lsCategoryList ,1)
		[ ] ListDelete (lsCategoryList ,1)
		[ ] 
		[ ] ////Calculate total budget for three categories
		[ ] iTotalBudget=iBudgetAmount*12*3
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] iResult= SelectAccountFromAccountBar(sAccountName, ACCOUNT_BANKING)
		[+] if (iResult==PASS)
			[+] for (iCounter=2 ; iCounter<=3; iCounter++)
				[ ] lsTransaction=lsTxnExcelData[iCounter]
				[+] if(lsTransaction[1]==NULL)
					[ ] break
				[ ] ///Calculate total spending
				[ ] iTxnAmount=VAL(lsTransaction[3])
				[ ] iTotalSpending =iTxnAmount*4+iTotalSpending
				[ ] 
				[+] if (iCounter>0)
					[+] for (iCount=3 ; iCount>=0; iCount--)
						[ ] QuickenWindow.SetActive()
						[ ] sDate=GetPreviousMonth(iCount)
						[ ] AddCheckingTransaction(lsTransaction[1],lsTransaction[2],lsTransaction[3],sDate,lsTransaction[5],lsTransaction[6],lsTransaction[7],lsTransaction[8])
						[ ] 
			[ ] 
			[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
			[+] if (iResult==PASS)
				[ ] sleep(2)
				[ ] iResult=DeleteBudget()
				[+] if (iResult==PASS)
					[ ] iResult=AddBudget(sBudgetName)
					[+] if (iResult==PASS)
						[ ] ReportStatus("Verify budget gets added.", PASS, "Budget: {sBudgetName} has been added.")
						[ ] 
						[ ] QuickenWindow.SetActive()
						[ ] 
						[ ] 
						[ ] //// Set Parent rollup on
						[ ] SelectBudgetOptionOnGraphAnnualView(sGraphView,"Rollup")
						[ ] sleep(2)
						[ ] 
						[ ] 
						[ ] QuickenWindow.SetActive()
						[+] for (iCounter=1 ;  iCounter<= 3; iCounter++)
							[ ] lsTransaction=lsTxnExcelData[iCounter]
							[+] if(lsTransaction[1]==NULL)
								[ ] break
							[ ] 
							[ ] sCategory=lsTransaction[8]
							[ ] iTxnAmount=VAL(lsTransaction[3])
							[ ] 
							[ ] lsRolloverData = CreateRollOverData(  sCategory, iBudgetAmount ,  iTxnAmount)
							[ ] sExpectedNoTxnRollOverAmount =lsRolloverData[2]
							[ ] sExpectedTxnRollOverAmount =lsRolloverData[3]
							[ ] iTotalRolloverAmount=iTotalRolloverAmount+lsRolloverData[1]
							[ ] iCatTotalRolloverAmount=lsRolloverData[1]
							[ ] 
							[ ] QuickenWindow.SetActive()
							[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sGraphView)
							[ ] sleep(4)
							[ ] 
							[ ] iResult=AddAverageBudget(sCategory ,iBudgetAmount)
							[+] if (iResult==PASS)
								[ ] ///Enable Rollover 
								[ ] 
								[ ] QuickenWindow.SetActive()
								[+] if(iCounter==1)
									[ ] iOccurrence=3
								[+] else
									[ ] iOccurrence=1
								[ ] SelectDeselectRollOverOptions (sCategory , sSetRollOverBalance)
								[ ] 
								[ ] 
								[ ] ////Select annual view on budget
								[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sAnnualView)
								[ ] sleep(4)
								[ ] MDIClient.Budget.AnnualViewTypeComboBox.Select("Balance only")
								[ ] sleep(2)
								[ ] QuickenWindow.SetActive()
								[+] if (MDIClient.Budget.ShowBalanceInFutureMonthsCheckBox.Exists(2))
									[ ] MDIClient.Budget.ShowBalanceInFutureMonthsCheckBox.Check()
									[ ] 
								[ ] 
								[ ] sleep(1)
								[ ] 
								[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
								[ ] iListCount= MDIClient.Budget.ListBox.GetItemCount() +1
								[+] for (iCount=1 ; iCount<=iListCount;++iCount)
									[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
									[ ] bMatch = MatchStr("*{sExpectedNoTxnRollOverAmount}*{sExpectedTxnRollOverAmount}*{iCatTotalRolloverAmount}*", sActual)
									[+] if (bMatch)
										[ ] break
								[+] if(bMatch)
									[ ] ReportStatus("Verify that category: {sCategory} item should support rollover." ,PASS, "The Category Total Balance values on Annual view included rollover for category: {sCategory} on Annual View as expected:{sExpectedNoTxnRollOverAmount}, {sExpectedTxnRollOverAmount}, {iCatTotalRolloverAmount}.")
								[+] else
									[ ] ReportStatus("Verify that category: {sCategory} item should support rollover." ,FAIL, "The Category Total Balance values on Annual view didn't include the rollover for category: {sCategory} on Annual View as actual: {sActual} is not as expected:{sExpectedNoTxnRollOverAmount}, {sExpectedTxnRollOverAmount},{iCatTotalRolloverAmount}.")
							[+] else
								[ ] ReportStatus("Verify that User is able to add average budget for category: {sCategory} with amount: {iBudgetAmount}."  , FAIL,"Average budget for category: {sCategory} with amount: {iBudgetAmount} couldn't be added for 12 months on Graph View.")
						[ ] ////Verify group total rollover amount
						[+] for (iCount=1 ; iCount<=iListCount;++iCount)
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
							[ ] bMatch = MatchStr("*{iTotalRolloverAmount}*", StrTran(sActual,",",""))
							[+] if (bMatch)
								[ ] break
						[+] if(bMatch)
							[ ] ReportStatus("Verify that Group Balance values on Annual view should include rollover." ,PASS, "The Category Total Balance values on Annual view included rollover for category group: {sCategoryType} on Annual View as expected:{iTotalRolloverAmount}.")
						[+] else
							[ ] ReportStatus("Verify that Group Balance values on Annual view should include rollover." ,FAIL, "The Category Total Balance values on Annual view didn't include the rollover for category group: {sCategoryType} on Annual View as actual: {sActual} is not as expected:{iTotalRolloverAmount}.")
						[ ] 
						[ ] ////Test 15: Verify that Summary bar "left" values should include rollover
						[ ] 
						[ ] ////Verify summary bar on Graph View
						[ ] QuickenWindow.SetActive()
						[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sGraphView)
						[ ] sleep(4)
						[ ] MDIClient.Budget.BudgetDurationComboBox.Select("Yearly")
						[ ] MDIClient.Budget.BudgetDurationComboBox.Select("Yearly")
						[ ] MDIClient.Budget.BudgetDurationComboBox.Select("Yearly")
						[ ] sleep(2)
						[ ] ///Verify Graph View Summary> Total Spending
						[ ] sActualSummaryTotalSpending = MDIClient.Budget.GraphViewSummaryTotalSpending.GetProperty("Caption")
						[ ] sActualSummaryTotalSpending=StrTran( sActualSummaryTotalSpending,"$","")
						[ ] sActualSummaryTotalSpending=StrTran( sActualSummaryTotalSpending,",","")
						[ ] 
						[ ] bMatch = MatchStr("*{str(iTotalSpending)}*" , sActualSummaryTotalSpending)
						[+] if (bMatch)
							[ ] ReportStatus("Verify that Summary bar left values should include rollover on Graph View" , PASS , "Summary bar spending: {sActualSummaryTotalSpending} is as expected: {iTotalSpending} on Graph View.")
						[+] else
							[ ] ReportStatus("Verify that Summary bar left values should include rollover on Graph View." , FAIL , "Summary bar spending: {sActualSummaryTotalSpending} is NOT as expected: {iTotalSpending} on Graph View due to Defect QW-3145.")
						[ ] 
						[ ] 
						[ ] ///Verify Graph View Summary> Total Budget
						[ ] sActualSummaryTotalBudget = MDIClient.Budget.GraphViewSummaryTotalBudget.GetProperty("Caption")
						[ ] sActualSummaryTotalBudget=StrTran( sActualSummaryTotalBudget,"$","")
						[ ] sActualSummaryTotalBudget=StrTran( sActualSummaryTotalBudget,",","")
						[ ] bMatch = MatchStr("*{str(iTotalBudget)}*" ,sActualSummaryTotalBudget)
						[+] if (bMatch)
							[ ] ReportStatus("Verify that Summary bar left values should include rollover on Graph View." , PASS , "Summary bar budget: {sActualSummaryTotalBudget} is as expected: {iTotalBudget} on Graph View.")
						[+] else
							[ ] ReportStatus("Verify that Summary bar left values should include rollover on Graph View." , FAIL , "Summary bar budget: {sActualSummaryTotalBudget} is NOT as expected: {iTotalBudget} on Graph View Defect QW-3145.")
						[ ] 
						[ ] ///Verify Graph View Summary> Left over
						[ ] iLeftover =iTotalRolloverAmount 
						[ ] sActualGraphViewSummaryTotalLeft = MDIClient.Budget.GraphViewSummaryTotalLeft.GetProperty("Caption")
						[ ] sActualGraphViewSummaryTotalLeft=StrTran( sActualGraphViewSummaryTotalLeft,"$","")
						[ ] sActualGraphViewSummaryTotalLeft=StrTran( sActualGraphViewSummaryTotalLeft,",","")
						[ ] 
						[ ] bMatch = MatchStr("*{str(iLeftover)}*" ,sActualGraphViewSummaryTotalLeft)
						[+] if (bMatch)
							[ ] ReportStatus("Verify that Summary bar left values should include rollover on Graph View." , PASS , "Summary bar leftover: {sActualGraphViewSummaryTotalLeft} is as expected: {iLeftover} on Graph View.")
						[+] else
							[ ] ReportStatus("Verify that Summary bar left values should include rollover on Graph View." , FAIL , "Summary bar leftover: {sActualGraphViewSummaryTotalLeft} is NOT as expected: {iLeftover} on Graph View Defect QW-3145.")
						[ ] 
						[ ] ////Verify summary bar on Annual View 
						[ ] QuickenWindow.SetActive()
						[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sAnnualView)
						[ ] sleep(4)
						[ ] ///Verify Annual View Summary> Total Spending
						[ ] 
						[ ] sActualSummaryTotalSpending = MDIClient.Budget.GraphViewSummaryTotalSpending.GetProperty("Caption")
						[ ] sActualSummaryTotalSpending=StrTran( sActualSummaryTotalSpending,"$","")
						[ ] sActualSummaryTotalSpending=StrTran( sActualSummaryTotalSpending,",","")
						[ ] 
						[ ] bMatch = MatchStr("*{str(iTotalSpending)}*" ,sActualSummaryTotalSpending)
						[+] if (bMatch)
							[ ] ReportStatus("Verify that Summary bar left values should include rollover on Annual View." , PASS , "Summary bar spending: {sActualSummaryTotalSpending} is as expected: {iTotalSpending} on Annual View.")
						[+] else
							[ ] ReportStatus("Verify that Summary bar left values should include rollover on Annual View." , FAIL , "Summary bar spending: {sActualSummaryTotalSpending} is NOT as expected: {iTotalSpending} on Annual View.")
						[ ] 
						[ ] 
						[ ] ///Verify Annual View Summary> Total Budget
						[ ] sActualSummaryTotalBudget = MDIClient.Budget.GraphViewSummaryTotalBudget.GetProperty("Caption")
						[ ] sActualSummaryTotalBudget=StrTran( sActualSummaryTotalBudget,"$","")
						[ ] sActualSummaryTotalBudget=StrTran( sActualSummaryTotalBudget,",","")
						[ ] 
						[ ] bMatch = MatchStr("*{str(iTotalBudget)}*" ,sActualSummaryTotalBudget)
						[+] if (bMatch)
							[ ] ReportStatus("Verify that Summary bar left values should include rollover on Annual View." , PASS , "Summary bar budget: {sActualSummaryTotalBudget} is as expected: {iTotalBudget} on Annual View.")
						[+] else
							[ ] ReportStatus("Verify that Summary bar left values should include rollover on Annual View." , FAIL , "Summary bar budget: {sActualSummaryTotalBudget} is NOT as expected: {iTotalBudget} on Annual View Defect QW-3145.")
						[ ] 
						[ ] ///Verify Annual View Summary> Left over
						[ ] iLeftover =iTotalRolloverAmount 
						[ ] sActualGraphViewSummaryTotalLeft = MDIClient.Budget.GraphViewSummaryTotalLeft.GetProperty("Caption")
						[ ] sActualGraphViewSummaryTotalLeft=StrTran( sActualGraphViewSummaryTotalLeft,"$","")
						[ ] sActualGraphViewSummaryTotalLeft=StrTran( sActualGraphViewSummaryTotalLeft,",","")
						[ ] 
						[ ] bMatch = MatchStr("*{str(iLeftover)}*" ,sActualGraphViewSummaryTotalLeft)
						[+] if (bMatch)
							[ ] ReportStatus("Verify that Summary bar left values should include rollover on Annual View." , PASS , "Summary bar leftover: {sActualGraphViewSummaryTotalLeft} is as expected: {iLeftover} on Annual View.")
						[+] else
							[ ] ReportStatus("Verify that Summary bar left values should include rollover on Annual View." , FAIL , "Summary bar leftover: {sActualGraphViewSummaryTotalLeft} is NOT as expected: {iLeftover} on Annual View Defect QW-3145.")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify budget gets added.", FAIL, "Budget: {sBudgetName} couldn't be added.")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify budget gets deleted.", FAIL, "Budget: {sBudgetName} couldn't be deleted.")
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
		[+] else
			[ ] ReportStatus("Verfiy account: {sAccountName} selected." , FAIL ,"Account: {sAccountName} coulkdn't be selected.")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
	[ ] 
[ ] 
[ ] ////#############Reports and Reminders##################/////
[ ] 
[ ] 
[+] //##########Test 1: Verify that Parent categories are presented in hierarchical display in reports even if only some subcategories belong to the Custom category group #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test1_VerifyThatThatParentCategoriesArePresentedInHierarchyInReportsEvenSomeSubCategoriesBelongToTheCustomCategoryGroup
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that Parent categories are presented in hierarchical display in reports even if only some subcategories belong to the Custom category group
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Parent categories are presented in hierarchical display in reports even if only some subcategories belong to the Custom category group. 
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  May 02 2014
		[ ] /////Note : TestCase not availble in updated sheet
	[ ] // ********************************************************
[ ] 
[+] testcase Test1_VerifyThatParentCategoriesArePresentedInHierarchyInReportsEvenSomeSubCategoriesBelongToTheCustomCategoryGroup() appstate none
	[+] //--------------Variable Declaration-------------
		[ ] INTEGER iParentCount
		[ ] iParentCount=0
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] sAccountName=lsAddAccount[2]
		[ ] // Fetch 1st row from sRegTransactionSheet the given sheet
		[ ] lsTxnExcelData=NULL
		[ ] lsTxnExcelData=ReadExcelTable(sBudgetExcelsheet, sRegTransactionSheet)
		[ ] ///Spending for firs
		[ ] lsTransaction=lsExcelData[1]
		[ ] iTxnAmount=VAL(lsTransaction[3])
		[ ] //Get current month as January 2014
		[ ] sCurrentMonth=FormatDateTime(GetDateTime(), "m") 
		[ ] iCurrentMonth = VAL(sCurrentMonth)
		[ ] iBudgetAmount=50
		[ ] ///Remove category type and parent category from the list
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] 
		[ ] lsCategoryList = lsExcelData[1]
		[ ] sCategoryType =lsCategoryList[1]
		[ ] sParentCategory=lsCategoryList[2]
		[ ] ListDelete (lsCategoryList ,1)
		[ ] ListDelete (lsCategoryList ,1)
		[ ] //Remove Car Wash from the list
		[ ] ListDelete (lsCategoryList ,3)
		[+] for( iCounter=1; iCounter <=ListCount (lsCategoryList) ; iCounter++)
			[+] if (lsCategoryList[iCounter]==NULL)
				[ ] ListDelete (lsCategoryList ,iCounter)
				[ ] iCounter--
				[ ] 
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] ////Create CustomCategory Group 
		[ ] iResult=AddCustomCategoryGroup (sCustomCatGroup )
		[ ] // iResult=PASS
		[+] if (iResult==PASS)
			[ ] ReportStatus("Verify Custom Category Group created. ", PASS , " Custom Category Group: {sCustomCatGroup} created.") 
			[ ] ///Verify custom category group added successfully
			[ ] iResult=AddCategoriesToCustomCategoryGroup  (sCustomCatGroup ,sCategoryType, lsCategoryList)
			[ ] // iResult=PASS
			[+] if (iResult==PASS)
				[ ] ReportStatus("Verify Categories  {lsCategoryList} is added to the custom group: {sCustomCatGroup}.", PASS , "Categories {lsCategoryList} is added to the custom group: {sCustomCatGroup}.") 
				[ ] 
				[ ] ////Navigate to budget and add custom categories to budget
				[ ] iResult=DeleteBudget()
				[+] if (iResult==PASS)
					[ ] iResult=AddBudget(sBudgetName)
					[+] if (iResult==PASS)
						[ ] ReportStatus("Verify budget gets added.", PASS, "Budget: {sBudgetName} has been added.")
						[+] for( iCounter=1; iCounter <=ListCount (lsCategoryList) ; iCounter++)
							[ ] sCategory=trim(lsCategoryList[iCounter])
							[ ] AddAverageBudget(sCategory ,iBudgetAmount)
							[ ] 
						[ ] 
						[ ] QuickenWindow.SetActive()
						[ ] //Set RollupOn on Graph View
						[ ] SelectBudgetOptionOnGraphAnnualView(sGraphView,"Rollup")
						[ ] QuickenWindow.SetActive()
						[ ] ///Select Current Budget report on Graph View
						[ ] ////Verify custom group categories
						[ ] 
						[ ] SelectBudgetReportOnGraphView(sREPORT_CURRENT_BUDGET)
						[+] if (CurrentBudget.Exists(2))
							[ ] CurrentBudget.SetActive()
							[ ] CurrentBudget.Maximize()
							[ ] iCatCount=1
							[ ] iParentCount=0
							[ ] sHandle= Str(CurrentBudget.ListBox.GetHandle())
							[ ] iListCount =CurrentBudget.ListBox.GetItemCount() 
							[+] for(iCount= 1; iCount <= iListCount;  iCount++)
								[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount-1))
								[ ] bMatch = MatchStr("*{sParentCategory}*", sActual)
								[ ] 
								[ ] 
								[+] if (bMatch)
									[ ] ReportStatus("Verify that Parent categories are presented in hierarchical display even some sub categories as part of the Custom Category group in the report.", PASS ,"Parent Category: {sParentCategory} on report: {sREPORT_CURRENT_BUDGET} found.")
									[ ] iCounter = iCount +1
									[ ] iParentCount=iParentCount+1
									[+] if (iParentCount==2)
										[+] for (iCount= iCounter; iCount < iCounter+ListCount(lsCategoryList);  iCount++)
											[ ] 
											[ ] //// iCatCount is used to iterate the category list
											[ ] 
											[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount-1))
											[ ] bResult = MatchStr("*{lsCategoryList[iCatCount]}*", sActual)
											[+] if (bResult)
												[ ] ReportStatus("Verify that Parent categories are presented in hierarchical display even some sub categories as part of the Custom Category group in the report.", PASS ,"Category:{lsCategoryList[iCatCount]} in report: {sREPORT_CURRENT_BUDGET} found in hierarchical order.")
											[+] else
												[ ] ReportStatus("Verify that Parent categories are presented in hierarchical display even if some subcategories belong to the Custom category group in the report. ", FAIL , " Category:{lsCategoryList[iCatCount]} didn't display as expected under parent: {sParentCategory}, actual category is: {sActual} in report: {sREPORT_CURRENT_BUDGET}.") 
											[ ] iCatCount++
										[ ] break
									[+] if (iParentCount==2)
										[ ] break
							[+] if (bMatch==FALSE)
								[ ] ReportStatus("Verify that Parent categories are presented in hierarchical display even some sub categories ar part of the Custom Category group in the report.", FAIL ,"Parent Category: {sParentCategory} on report: {sREPORT_CURRENT_BUDGET} couldn't be found.")
							[ ] CurrentBudget.SetActive()
							[ ] CurrentBudget.Close()
							[ ] WaitForState(CurrentBudget , False ,2)
						[+] else
							[ ] ReportStatus("Verify report: {sREPORT_CURRENT_BUDGET} on budget Graph View.", FAIL , " {sREPORT_CURRENT_BUDGET} on budget Graph View didn't appear.") 
						[ ] ///Select Historical Budget report on Graph View
						[ ] 
						[ ] SelectBudgetReportOnGraphView(sREPORT_HISTORICAL_BUDGET)
						[+] if (HistoricalBudget.Exists(2))
							[ ] HistoricalBudget.SetActive()
							[ ] HistoricalBudget.Maximize()
							[ ] iParentCount=0
							[ ] iCatCount=1
							[ ] sHandle= Str(HistoricalBudget.ListBox.GetHandle())
							[ ] iListCount =HistoricalBudget.ListBox.GetItemCount() 
							[+] for(iCount= 1; iCount <= iListCount;  iCount++)
								[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount-1))
								[ ] bMatch = MatchStr("*{sParentCategory}*", sActual)
								[+] if (bMatch)
									[ ] ReportStatus("Verify that Parent categories are presented in hierarchical display even some sub categories as part of the Custom Category group in the report.", PASS ,"Parent Category: {sParentCategory} on report: {sREPORT_HISTORICAL_BUDGET} found.")
									[ ] iCounter = iCount +1
									[ ] iParentCount=iParentCount+1
									[+] if (iParentCount==2)
										[+] for (iCount= iCounter; iCount < iCounter+ListCount(lsCategoryList);  iCount++)
											[ ] 
											[ ] //// iCatCount is used to iterate the category list
											[ ] 
											[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount-1))
											[ ] bResult = MatchStr("*{lsCategoryList[iCatCount]}*", sActual)
											[+] if (bResult)
												[ ] ReportStatus("Verify that Parent categories are presented in hierarchical display even some sub categories as part of the Custom Category group in the report.", PASS ,"Category: {lsCategoryList[iCatCount]} in report: {sREPORT_HISTORICAL_BUDGET} found in hierarchical order.")
											[+] else
												[ ] ReportStatus("Verify that Parent categories are presented in hierarchical display even if some subcategories belong to the Custom category group in the report. ", FAIL , " Category:{lsCategoryList[iCatCount]} didn't display as expected under parent: {sParentCategory}, actual category is: {sActual} in report: {sREPORT_HISTORICAL_BUDGET}.") 
											[ ] iCatCount++
										[ ] break
										[ ] 
									[+] if (iParentCount==2)
										[ ] break
									[ ] 
							[+] if (bMatch==FALSE)
								[ ] ReportStatus("Verify that Parent categories are presented in hierarchical display even some sub categories ar part of the Custom Category group in the report.", FAIL ,"Parent Category: {sParentCategory} couldn't be found on report: {sREPORT_HISTORICAL_BUDGET} .")
							[ ] HistoricalBudget.SetActive()
							[ ] HistoricalBudget.Close()
							[ ] WaitForState(HistoricalBudget , False ,2)
						[+] else
							[ ] ReportStatus("Verify report: {sREPORT_CURRENT_BUDGET} on budget Graph View.", FAIL , " {sREPORT_CURRENT_BUDGET} on budget Graph View didn't appear.") 
							[ ] 
							[ ] 
							[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify budget gets added.", FAIL, "Budget: {sBudgetName} couldn't be added.")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify budget gets deleted.", FAIL, "Budget: {sBudgetName} couldn't be deleted.")
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Categories {lsCategoryList} is added to the custom group: {sCustomCatGroup}.", FAIL , "Categories {lsCategoryList} didn't add to the custom group: {sCustomCatGroup}.") 
		[+] else
			[ ] ReportStatus("Verify Custom Category Group created. ", FAIL , " Custom Category Group: {sCustomCatGroup} couldn't be created.") 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
[ ] // 
[+] //##########Test 2: Verify the Rollup calculation for Parent categories when the presented in hierarchical display even if only some subcategories belong to the Custom category group  ############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test2_VerifyTheRollUpCalculationForParentCategoriesWhenPresentedInHierarchyInReportsEvenSomeSubCategoriesBelongToTheCustomCategoryGroup
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify the Rollup calculation for Parent categories when the presented in hierarchical display even if only some subcategories belong to the Custom category group 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Rollup calculation for Parent categories when the presented in hierarchical display even if only some subcategories belong to the Custom category group 
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  May 02 2014
		[ ] /////Note : TestCase not availble in updated sheet
	[ ] // ********************************************************
[ ] //need to fix
[+] testcase Test2_VerifyTheRollUpCalculationForParentCatsWhenPresentedInHierarchyInReportsEvenSomeSubCatsBelongToTheCustCatGroup() appstate none
	[+] //--------------Variable Declaration-------------
		[ ] BOOLEAN bLeapYear =FALSE
		[ ] REAL rTotalBudget ,rCurrentMonthBudget ,rBudgetAmount
		[ ] STRING sCurrentDay
		[ ] INTEGER iCurrentDay ,iCategoryCount
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sAccountWorksheet)
		[ ] 
		[ ] lsAddAccount=lsExcelData[1]
		[ ] sAccountName=lsAddAccount[2]
		[ ] // Fetch 1st row from sRegTransactionSheet the given sheet
		[ ] lsTxnExcelData=NULL
		[ ] lsTxnExcelData=ReadExcelTable(sBudgetExcelsheet, sRegTransactionSheet)
		[ ] ///Spending for firs
		[ ] lsTransaction=lsExcelData[1]
		[ ] iTxnAmount=VAL(lsTransaction[3])
		[ ] rTotalBudget=0
		[ ] rBudgetAmount=50
		[ ] //today
		[ ] sCurrentDay=FormatDateTime(GetDateTime(), "dd") 
		[ ] iCurrentDay = VAL(sCurrentDay)
		[ ] //Year 
		[ ] sYear=FormatDateTime(GetDateTime(), "yyyy") 
		[ ] iYear =VAL (sYear)
		[+] if  (iYear%400==0)
			[ ] bLeapYear=TRUE
		[+] else if (iYear%4==0)
			[ ] bLeapYear=TRUE
		[+] else if (iYear%100==0)
			[ ] bLeapYear=FALSE
		[+] else
			[ ] bLeapYear=FALSE
			[ ] 
		[ ] //Get current month as January 2014
		[ ] sCurrentMonth=FormatDateTime(GetDateTime(), "m") 
		[ ] iCurrentMonth = VAL(sCurrentMonth)
		[ ] 
		[ ] 
		[ ] //
		[ ] //Calculate no. of days in current month
		[+] if (iCurrentMonth==1 ||iCurrentMonth==3 ||iCurrentMonth==5 ||iCurrentMonth==7 ||iCurrentMonth==8 ||iCurrentMonth==10 || iCurrentMonth==12)
			[ ] iDays=31
		[+] else if (iCurrentMonth==4 ||iCurrentMonth==6 ||iCurrentMonth==9 ||iCurrentMonth==11)
			[ ] iDays=30
		[+] else if (bLeapYear)
			[ ] iDays=29
		[+] else
			[ ] iDays=28
		[ ] ///Remove category type and parent category from the list
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] 
		[ ] lsCategoryList = lsExcelData[1]
		[ ] sCategoryType =lsCategoryList[1]
		[ ] sParentCategory=lsCategoryList[2]
		[ ] ListDelete (lsCategoryList ,1)
		[ ] ListDelete (lsCategoryList ,1)
		[ ] ListDelete (lsCategoryList ,1)
		[ ] //Remove Car Wash from the list
		[ ] 
		[+] for( iCounter=1; iCounter <=ListCount (lsCategoryList) ; iCounter++)
			[+] if (lsCategoryList[iCounter]==NULL)
				[ ] ListDelete (lsCategoryList ,iCounter)
				[ ] iCounter--
				[ ] 
		[ ] 
		[ ] 
	[ ] iCategoryCount=ListCount (lsCategoryList)
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //Calculate budget rollup 
		[+] if(iCurrentMonth>1)
			[ ] rTotalBudget=rBudgetAmount*(iCurrentMonth-1)*iCategoryCount
		[ ] //Current Month budget
		[ ] 
		[ ] rCurrentMonthBudget=(rBudgetAmount/iDays)*iCurrentDay*iCategoryCount
		[ ] 
		[ ] rTotalBudget=rTotalBudget+rCurrentMonthBudget
		[ ] ///Select Current Budget report on Graph View
		[ ] //Verify the Rollup calculation for Parent categories 
		[ ] SelectBudgetReportOnGraphView(sREPORT_CURRENT_BUDGET)
		[+] if (CurrentBudget.Exists(2))
			[ ] CurrentBudget.SetActive()
			[ ] CurrentBudget.Maximize()
			[ ] iCatCount=1
			[ ] sHandle= Str(CurrentBudget.ListBox.GetHandle())
			[ ] iListCount =CurrentBudget.ListBox.GetItemCount() 
			[+] for(iCount= 1; iCount <= iListCount;  iCount++)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount-1))
				[ ] bMatch = MatchStr("*{sParentCategory}*", sActual)
				[+] if (bMatch)
					[ ] bMatch = MatchStr("*{trim(str(rTotalBudget,4,2))}*", sActual)
					[+] if (bMatch)
						[ ] ReportStatus("Verify the Rollup calculation for Parent categories when the presented in hierarchical display even if only some subcategories belong to the Custom category group.", PASS ,"Rollup calculation for parent category: {sParentCategory} is as expected: {rTotalBudget} on report: {sREPORT_CURRENT_BUDGET}.")
					[+] else
						[ ] ReportStatus("Verify the Rollup calculation for Parent categories when the presented in hierarchical display even if only some subcategories belong to the Custom category group.", FAIL ,"Rollup calculation for parent category: {sParentCategory} actual: {sActual} is NOT as expected: {rTotalBudget} on report: {sREPORT_CURRENT_BUDGET} Defect QW-3145.")
					[ ] break
			[+] if (bMatch==FALSE)
				[ ] ReportStatus("Verify the Rollup calculation for Parent categories when the presented in hierarchical display even if only some subcategories belong to the Custom category group.", FAIL ,"Parent Category: {sParentCategory} on report: {sREPORT_CURRENT_BUDGET} couldn't be found.")
			[ ] CurrentBudget.SetActive()
			[ ] CurrentBudget.Close()
			[ ] WaitForState(CurrentBudget , False ,2)
		[+] else
			[ ] ReportStatus("Verify report: {sREPORT_CURRENT_BUDGET} on budget Graph View.", FAIL , " {sREPORT_CURRENT_BUDGET} on budget Graph View didn't appear.") 
		[ ] ///Select Historical Budget report on Graph View
		[ ] //Calculate budget rollup 
		[ ] rTotalBudget=rBudgetAmount*12*iCategoryCount
		[ ] //Current Month budget
		[ ] 
		[ ] rCurrentMonthBudget=(rBudgetAmount/iDays)*iCurrentDay*iCategoryCount
		[ ] 
		[ ] rTotalBudget=rTotalBudget+rCurrentMonthBudget
		[ ] 
		[ ] 
		[ ] //Verify the Rollup calculation for Parent categories 
		[ ] SelectBudgetReportOnGraphView(sREPORT_HISTORICAL_BUDGET)
		[+] if (HistoricalBudget.Exists(2))
			[ ] HistoricalBudget.SetActive()
			[ ] HistoricalBudget.Maximize()
			[ ] iCatCount=1
			[ ] sHandle= Str(HistoricalBudget.ListBox.GetHandle())
			[ ] iListCount =HistoricalBudget.ListBox.GetItemCount() 
			[+] for(iCount= 1; iCount <= iListCount;  iCount++)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount-1))
				[ ] bMatch = MatchStr("*{sParentCategory}*", sActual)
				[+] if (bMatch)
					[ ] bMatch = MatchStr("*{trim(str(rTotalBudget,4,2))}*", sActual)
					[+] if (bMatch)
						[ ] ReportStatus("Verify the Rollup calculation for Parent categories when the presented in hierarchical display even if only some subcategories belong to the Custom category group.", PASS ,"Rollup calculation for parent category: {sParentCategory} is as expected: {rTotalBudget} on report: {sREPORT_HISTORICAL_BUDGET}.")
					[+] else
						[ ] ReportStatus("Verify the Rollup calculation for Parent categories when the presented in hierarchical display even if only some subcategories belong to the Custom category group.", FAIL ,"Rollup calculation for parent category: {sParentCategory} actual: {sActual} is NOT as expected: {rTotalBudget} on report: {sREPORT_HISTORICAL_BUDGET} Defect QW-3145.")
					[ ] break
			[+] if (bMatch==FALSE)
				[ ] ReportStatus("Verify the Rollup calculation for Parent categories when the presented in hierarchical display even if only some subcategories belong to the Custom category group.", FAIL ,"Parent Category: {sParentCategory} couldn't be found on report: {sREPORT_HISTORICAL_BUDGET} .")
			[ ] HistoricalBudget.SetActive()
			[ ] HistoricalBudget.Close()
			[ ] WaitForState(HistoricalBudget , False ,2)
		[+] else
			[ ] ReportStatus("Verify report: {sREPORT_HISTORICAL_BUDGET} on budget Graph View.", FAIL , " {sREPORT_HISTORICAL_BUDGET} on budget Graph View didn't appear.") 
			[ ] 
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
[+] //##########Test 3: Verify the Right click menu options for Mixed Groups############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test3_VerifyTheRightClickMenuOptionsForMixedGroups
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify the Right click menu options for Mixed Groups
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Right click menu options for Mixed Groups work correctly
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  May 06 2014
		[ ] /////Note : TestCase not availble in updated sheet
	[ ] // ********************************************************
[ ] 
[+] testcase Test3_VerifyTheRightClickMenuOptionsForMixedGroups() appstate none
	[+] //--------------Variable Declaration-------------
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] sAccountName=lsAddAccount[2]
		[ ] // Fetch 1st row from sRegTransactionSheet the given sheet
		[ ] lsTxnExcelData=NULL
		[ ] lsTxnExcelData=ReadExcelTable(sBudgetExcelsheet, sRegTransactionSheet)
		[ ] ///Spending for firs
		[ ] lsTransaction=lsExcelData[1]
		[ ] iTxnAmount=VAL(lsTransaction[3])
		[ ] //Get current month as January 2014
		[ ] sCurrentMonth=FormatDateTime(GetDateTime(), "m") 
		[ ] iCurrentMonth = VAL(sCurrentMonth)
		[ ] iBudgetAmount=50
		[ ] ///Remove category type and parent category from the list
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] 
		[ ] lsCategoryList = lsExcelData[1]
		[ ] sCategoryType =lsCategoryList[1]
		[ ] sParentCategory=lsCategoryList[2]
		[ ] ListDelete (lsCategoryList ,1)
		[ ] ListDelete (lsCategoryList ,1)
		[+] for( iCounter=1; iCounter <=ListCount (lsCategoryList) ; iCounter++)
			[+] if (lsCategoryList[iCounter]==NULL)
				[ ] ListDelete (lsCategoryList ,iCounter)
				[ ] iCounter--
				[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] ////Create CustomCategory Group 
		[ ] iResult=AddCustomCategoryGroup (sCustomCatGroup )
		[ ] ///Verify custom category group added successfully
		[ ] // iResult=PASS
		[+] if (iResult==PASS)
			[ ] ReportStatus("Verify Custom Category Group created. ", PASS , " Custom Category Group: {sCustomCatGroup} created.") 
			[ ] ///Verify Expense categoiries added to custom category group successfully
			[ ] iResult=AddCategoriesToCustomCategoryGroup  (sCustomCatGroup ,sCategoryType, lsCategoryList)
			[ ] ///Verify Income categoiries added to custom category group successfully
			[ ] lsCategoryList = lsExcelData[3]
			[ ] sCategoryType =lsCategoryList[1]
			[ ] sParentCategory=lsCategoryList[2]
			[ ] ListDelete (lsCategoryList ,1)
			[+] for( iCounter=1; iCounter <=ListCount (lsCategoryList) ; iCounter++)
				[+] if (lsCategoryList[iCounter]==NULL)
					[ ] ListDelete (lsCategoryList ,iCounter)
					[ ] iCounter--
					[ ] 
			[ ] iResult=AddCategoriesToCustomCategoryGroup  (sCustomCatGroup ,sCategoryType, lsCategoryList)
			[ ] // iResult=PASS
			[+] if (iResult==PASS)
				[ ] ReportStatus("Verify Categories  {lsCategoryList} is added to the custom group: {sCustomCatGroup}.", PASS , "Categories {lsCategoryList} is added to the custom group: {sCustomCatGroup}.") 
				[ ] 
				[ ] ////Navigate to budget and add custom categories to budget
				[ ] iResult=DeleteBudget()
				[+] if (iResult==PASS)
					[ ] iResult=AddBudget(sBudgetName)
					[+] if (iResult==PASS)
						[ ] ReportStatus("Verify budget gets added.", PASS, "Budget: {sBudgetName} has been added.")
						[+] for( iCounter=1; iCounter <=ListCount (lsCategoryList) ; iCounter++)
							[ ] sCategory=trim(lsCategoryList[iCounter])
							[ ] AddAverageBudget(sCategory ,iBudgetAmount)
							[ ] 
						[ ] 
						[ ] QuickenWindow.SetActive()
						[ ] //Set RollupOn on Graph View
						[ ] SelectBudgetOptionOnGraphAnnualView(sGraphView,"Rollup")
						[ ] QuickenWindow.SetActive()
						[ ] ///Now verify the Mixed goup options
						[ ] ///Verify converting mixed group as income
						[ ] MDIClient.Budget.ListBox.TextClick(sCustomCatGroup ,NULL,CT_RIGHT)
						[ ] MDIClient.Budget.ListBox.Typekeys(KEY_DN)
						[ ] MDIClient.Budget.ListBox.Typekeys(KEY_RT)
						[ ] MDIClient.Budget.ListBox.Typekeys(KEY_ENTER)
						[ ] //After converting mixed group as Income the budget amount should become negative for the root category
						[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
						[ ] iListCount= MDIClient.Budget.ListBox.GetItemCount() +1
						[+] for (iCount=1 ; iCount<=iListCount;++iCount)
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
							[ ] bMatch = MatchStr("*{sCustomCatGroup}*", sActual)
							[+] if (bMatch)
								[ ] bMatch = MatchStr("*{-iBudgetAmount*3}*", sActual)
								[+] if (bMatch)
									[ ] ReportStatus("Verify the Right click menu options for Mixed Groups->Income." ,PASS, "Mixed group has been setup as Income groups as budget of expense categories became negative as expected:{-iBudgetAmount*3}.")
								[+] else
									[ ] ReportStatus("Verify the Right click menu options for Mixed Groups->Income." ,FAIL, "Mixed group couldn't be setup as Income groups as budget of expense categories actula is : {sActual} is not as expected:{-iBudgetAmount*3}.")
								[ ] break
						[+] if(bMatch==FALSE)
							[ ] ReportStatus("Verify the Right click menu options for Mixed Groups->Income." ,FAIL, "Custom category goup: {sCustomCatGroup} couldn't be found.")
						[ ] ////Restart Quicken and verify setting persists
						[ ] LaunchQuicken()
						[ ] sleep(2)
						[ ] //After converting mixed group as Income the budget amount should become negative for the root category
						[ ] iResult = NavigateQuickenTab(sTAB_PLANNING,sTAB_BUDGET)
						[+] if (iResult==PASS)
							[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
							[ ] iListCount= MDIClient.Budget.ListBox.GetItemCount() +1
							[+] for (iCount=1 ; iCount<=iListCount;++iCount)
								[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
								[ ] bMatch = MatchStr("*{sCustomCatGroup}*", sActual)
								[+] if (bMatch)
									[ ] bMatch = MatchStr("*{-iBudgetAmount*3}*", sActual)
									[+] if (bMatch)
										[ ] ReportStatus("Verify the Right click menu options for Mixed Groups->Income." ,PASS, "Mixed group has been setup as Income groups as budget of expense categories became negative as expected:{-iBudgetAmount*3}.")
									[+] else
										[ ] ReportStatus("Verify the Right click menu options for Mixed Groups->Income." ,FAIL, "Mixed group couldn't be setup as Income groups as budget of expense categories actula is : {sActual} is not as expected:{-iBudgetAmount*3}.")
									[ ] break
							[+] if(bMatch==FALSE)
								[ ] ReportStatus("Verify the Right click menu options for Mixed Groups->Income." ,FAIL, "Custom category goup: {sCustomCatGroup} couldn't be found.")
						[+] else
							[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
						[ ] 
						[ ] ///Verify converting mixed group as expense
						[ ] MDIClient.Budget.ListBox.TextClick(sCustomCatGroup ,NULL,CT_RIGHT)
						[ ] MDIClient.Budget.ListBox.Typekeys(KEY_DN)
						[ ] MDIClient.Budget.ListBox.Typekeys(KEY_RT)
						[ ] MDIClient.Budget.ListBox.Typekeys(KEY_DN)
						[ ] MDIClient.Budget.ListBox.Typekeys(KEY_ENTER)
						[ ] //After converting mixed group as Expense the budget amount should become positive for the root category
						[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
						[ ] iListCount= MDIClient.Budget.ListBox.GetItemCount() +1
						[+] for (iCount=1 ; iCount<=iListCount;++iCount)
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
							[ ] bMatch = MatchStr("*{sCustomCatGroup}*", sActual)
							[+] if (bMatch)
								[ ] bMatch = MatchStr("*{iBudgetAmount*3}*", sActual)
								[+] if (bMatch)
									[ ] ReportStatus("Verify the Right click menu options for Mixed Groups->Expense." ,PASS, "Mixed group has been setup as Expense group as budget of expense categories became negative as expected:{iBudgetAmount*3}.")
								[+] else
									[ ] ReportStatus("Verify the Right click menu options for Mixed Groups->Expense." ,FAIL, "Mixed group couldn't be setup as Expense group as budget of expense categories actula is : {sActual} is not as expected:{iBudgetAmount*3}.")
								[ ] break
						[+] if(bMatch==FALSE)
							[ ] ReportStatus("Verify the Right click menu options for Mixed Groups->Income." ,FAIL, "Custom category goup: {sCustomCatGroup} couldn't be found.")
						[ ] 
						[ ] ////Restart Quicken and verify setting persists
						[ ] LaunchQuicken()
						[ ] sleep(2)
						[ ] //After converting mixed group as Income the budget amount should become negative for the root category
						[ ] iResult = NavigateQuickenTab(sTAB_PLANNING,sTAB_BUDGET)
						[+] if (iResult==PASS)
							[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
							[ ] iListCount= MDIClient.Budget.ListBox.GetItemCount() +1
							[+] for (iCount=1 ; iCount<=iListCount;++iCount)
								[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
								[ ] bMatch = MatchStr("*{sCustomCatGroup}*", sActual)
								[+] if (bMatch)
									[ ] bMatch = MatchStr("*{iBudgetAmount*3}*", sActual)
									[+] if (bMatch)
										[ ] ReportStatus("Verify the Right click menu options for Mixed Groups->Expense." ,PASS, "Mixed group has been setup as Expense group as budget of expense categories became negative as expected:{iBudgetAmount*3}.")
									[+] else
										[ ] ReportStatus("Verify the Right click menu options for Mixed Groups->Expense." ,FAIL, "Mixed group couldn't be setup as Expense group as budget of expense categories actula is : {sActual} is not as expected:{iBudgetAmount*3}.")
									[ ] break
							[+] if(bMatch==FALSE)
								[ ] ReportStatus("Verify the Right click menu options for Mixed Groups->Income." ,FAIL, "Custom category goup: {sCustomCatGroup} couldn't be found.")
						[+] else
							[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
						[ ] 
						[ ] ///Verify converting mixed group as Ignore
						[ ] MDIClient.Budget.ListBox.TextClick(sCustomCatGroup ,NULL,CT_RIGHT)
						[ ] MDIClient.Budget.ListBox.Typekeys(KEY_DN)
						[ ] MDIClient.Budget.ListBox.Typekeys(KEY_RT)
						[ ] MDIClient.Budget.ListBox.Typekeys(replicate(KEY_DN,2))
						[ ] MDIClient.Budget.ListBox.Typekeys(KEY_ENTER)
						[ ] //After converting mixed group as Ignore the budget amount should become nill for the root category
						[ ] STRING sDash="-"
						[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
						[ ] iListCount= MDIClient.Budget.ListBox.GetItemCount() +1
						[+] for (iCount=1 ; iCount<=iListCount;++iCount)
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
							[ ] bMatch = MatchStr("*{sCustomCatGroup}*", sActual)
							[+] if (bMatch)
								[ ] bMatch = MatchStr("*{sDash}*", sActual)
								[+] if (bMatch)
									[ ] ReportStatus("Verify the Right click menu options for Mixed Groups->Ignore." ,PASS, "Mixed group has been setup as Ignore group as budget of expense categories became nill as expected:{sDash}.")
								[+] else
									[ ] ReportStatus("Verify the Right click menu options for Mixed Groups->Ignore." ,FAIL, "Mixed group couldn't be setup as Ignore group as budget of expense categories actula is : {sActual} is not as expected:{sDash}.")
								[ ] break
						[+] if(bMatch==FALSE)
							[ ] ReportStatus("Verify the Right click menu options for Mixed Groups->Income." ,FAIL, "Custom category goup: {sCustomCatGroup} couldn't be found.")
						[ ] ////Restart Quicken and verify setting persists
						[ ] LaunchQuicken()
						[ ] sleep(2)
						[ ] //After converting mixed group as Income the budget amount should become negative for the root category
						[ ] iResult = NavigateQuickenTab(sTAB_PLANNING,sTAB_BUDGET)
						[+] if (iResult==PASS)
							[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
							[ ] iListCount= MDIClient.Budget.ListBox.GetItemCount() +1
							[+] for (iCount=1 ; iCount<=iListCount;++iCount)
								[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
								[ ] bMatch = MatchStr("*{sCustomCatGroup}*", sActual)
								[+] if (bMatch)
									[ ] bMatch = MatchStr("*{sDash}*", sActual)
									[+] if (bMatch)
										[ ] ReportStatus("Verify the Right click menu options for Mixed Groups->Ignore." ,PASS, "Mixed group has been setup as Ignore group as budget of expense categories became nill as expected:{sDash}.")
									[+] else
										[ ] ReportStatus("Verify the Right click menu options for Mixed Groups->Ignore." ,FAIL, "Mixed group couldn't be setup as Ignore group as budget of expense categories actula is : {sActual} is not as expected:{sDash}.")
									[ ] break
							[+] if(bMatch==FALSE)
								[ ] ReportStatus("Verify the Right click menu options for Mixed Groups->Income." ,FAIL, "Custom category goup: {sCustomCatGroup} couldn't be found.")
						[+] else
							[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify budget gets added.", FAIL, "Budget: {sBudgetName} couldn't be added.")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify budget gets deleted.", FAIL, "Budget: {sBudgetName} couldn't be deleted.")
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Categories {lsCategoryList} is added to the custom group: {sCustomCatGroup}.", FAIL , "Categories {lsCategoryList} didn't add to the custom group: {sCustomCatGroup}.") 
		[+] else
			[ ] ReportStatus("Verify Custom Category Group created. ", FAIL , " Custom Category Group: {sCustomCatGroup} couldn't be created.") 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
[ ] 
[+] //##########Test5: Verify that by default reminders are considered in budget############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test4_VerifyThatByDefaultRemindersAreConsideredInBudget
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that by default reminders are considered in budget
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If by default reminders are considered in budget
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  May 09 2014
		[ ] /////Note : TestCase not availble in updated sheet
	[ ] // ********************************************************
[ ] 
[+] testcase Test5_VerifyThatByDefaultRemindersAreConsideredInBudget() appstate none
	[+] //--------------Variable Declaration-------------
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] sAccountName=lsAddAccount[2]
		[ ] ///Spending for firs
		[ ] lsTransaction=lsExcelData[1]
		[ ] iTxnAmount=VAL(lsTransaction[3])
		[ ] //Get current month as January 2014
		[ ] sCurrentMonth=FormatDateTime(GetDateTime(), "m") 
		[ ] iCurrentMonth = VAL(sCurrentMonth)
		[ ] iBudgetAmount=50
		[ ] 
		[ ] // Fetch 1st row from sBillWorksheet the given sheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sBillWorksheet)
		[ ] lsReminderData=lsExcelData[1]
		[ ] ///Remove category type and parent category from the list
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] 
		[ ] lsCategoryList = lsExcelData[1]
		[ ] sCategoryType =lsCategoryList[1]
		[ ] sParentCategory=lsCategoryList[2]
		[ ] sCategory = trim(lsCategoryList[3])
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] lsReminderData[3]=sDate
		[ ] iResult=NavigateQuickenTab(sTAB_BILL)
		[+] if (iResult==PASS)
			[+] if(AddReminderButton.Exists())
				[ ] AddReminderButton.Click()
				[ ] AddReminderButton.TypeKeys(KEY_DN, 1) 
				[ ] AddReminderButton.TypeKeys(KEY_ENTER)
				[ ] 
				[ ] 
				[ ] iResult = AddBill(lsReminderData[1],trim(str(iBudgetAmount)) , lsReminderData[3], lsReminderData[4], sCategory,lsReminderData[6], lsReminderData[7])
				[+] if (iResult == PASS)
					[ ] 
					[ ] sExpectedAmount= Str(Val(lsReminderData[2]))
					[ ] 
					[ ] ReportStatus("Verify create new Bill ", PASS, "New Bill with Payee Name {lsReminderData[1]} and amount {sExpectedAmount} created")
					[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
					[+] if (iResult==PASS)
						[ ] sleep(2)
						[ ] ///Verify reminder on Graph View Summary using Left over
						[ ] 
						[ ] sActualGraphViewSummaryTotalLeft = MDIClient.Budget.GraphViewSummaryTotalLeft.GetProperty("Caption")
						[ ] bMatch = MatchStr("*{str(iBudgetAmount)}*" ,StrTran( sActualGraphViewSummaryTotalLeft,"$",""))
						[+] if (bMatch)
							[ ] ReportStatus("Verify that by default reminders are considered in budget." , PASS , "Summary bar leftover included reminder with amount: {sActualGraphViewSummaryTotalLeft} is as expected: {iBudgetAmount} on Graph View.")
						[+] else
							[ ] ReportStatus("Verify that by default reminders are considered in budget." , FAIL , "Summary bar leftover didn't include reminder with amount: {iBudgetAmount} as actual leftover is: {sActualGraphViewSummaryTotalLeft} on Graph View.")
						[ ] 
						[ ] 
						[ ] ///Restart the quicken and verify the option persists
						[ ] LaunchQuicken()
						[ ] Sleep(2)
						[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
						[+] if (iResult==PASS)
							[ ] sleep(2)
							[ ] ///Verify reminder on Graph View Summary using Left over
							[ ] 
							[ ] sActualGraphViewSummaryTotalLeft = MDIClient.Budget.GraphViewSummaryTotalLeft.GetProperty("Caption")
							[ ] bMatch = MatchStr("*{str(iBudgetAmount)}*" ,StrTran( sActualGraphViewSummaryTotalLeft,"$",""))
							[+] if (bMatch)
								[ ] ReportStatus("Verify that users selected options persist for Include Reminders." , PASS , "Summary bar leftover included reminder with amount: {sActualGraphViewSummaryTotalLeft} is as expected: {iBudgetAmount} on Graph View after restarting quicken.")
							[+] else
								[ ] ReportStatus("Verify that users selected options persist for Include Reminders." , FAIL , "Summary bar leftover didn't include reminder with amount: {iBudgetAmount} as actual leftover is: {sActualGraphViewSummaryTotalLeft} on Graph View after restarting quicken.")
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
				[+] else
					[ ] ReportStatus("Verify create new Bill ", FAIL, "New Bill with Payee Name {lsReminderData[1]} and amount {sExpectedAmount} is not created")
			[+] else
				[ ] ReportStatus("Verify Add Reminder button exists on Bills tab." , FAIL , "Add Reminder button doesn't exist on Bills tab.")
		[+] else
			[ ] ReportStatus("Verify Quicken navigated to Bills tab." , FAIL ,"Quicken didn't navigate to Bills tab.")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
[ ] 
[+] //##########Test 6: Verify that users selected options persists for "Include Reminders" ############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test6_VerifyThatUsersSelectedOptionPersistsForIncludeReminders
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that users selected options persists for "Include Reminders"
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If users selected options persists for "Include Reminders"
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  May 09 2014
		[ ] /////Note : TestCase not availble in updated sheet
	[ ] // ********************************************************
[ ] 
[+] testcase Test6_VerifyThatUsersSelectedOptionPersistsForIncludeReminders() appstate none
	[+] //--------------Variable Declaration-------------
		[ ] STRING sReminderOption
		[ ] iBudgetAmount=50
		[ ] sReminderOption= "Include Reminders"
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
		[+] if (iResult==PASS)
			[ ] sleep(2)
			[ ] ///Uncheck the "Include Reminders" option on Budget>Actions>Options
			[ ] SelectBudgetOptionOnGraphAnnualView(sGraphView,sReminderOption)
			[ ] ///Verify reminder on Graph View Summary using Left over
			[ ] sActualGraphViewSummaryTotalLeft = MDIClient.Budget.GraphViewSummaryTotalLeft.GetProperty("Caption")
			[ ] bMatch = MatchStr("*{str(iBudgetAmount)}*" ,StrTran( sActualGraphViewSummaryTotalLeft,"$",""))
			[+] if (bMatch==FALSE)
				[ ] ReportStatus("Verify that users selected options persist for Include Reminders when Show reminders option is unchecked." , PASS ,  "Summary bar leftover didn't include reminder with amount: {iBudgetAmount} as actual leftover is: {sActualGraphViewSummaryTotalLeft} on Graph View when Show reminders option is unchecked.")
			[+] else
				[ ] ReportStatus("Verify that users selected options persist for Include Reminders when Show reminders option is unchecked." , FAIL ,  "Summary bar leftover included reminder with amount: {sActualGraphViewSummaryTotalLeft}  on Graph View when Show reminders option is unchecked.")
			[ ] 
			[ ] 
			[ ] ///Restart the quicken and verify the option persists
			[ ] LaunchQuicken()
			[ ] Sleep(2)
			[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
			[+] if (iResult==PASS)
				[ ] sleep(2)
				[ ] ///Verify reminder on Graph View Summary using Left over
				[ ] 
				[ ] sActualGraphViewSummaryTotalLeft = MDIClient.Budget.GraphViewSummaryTotalLeft.GetProperty("Caption")
				[ ] bMatch = MatchStr("*{str(iBudgetAmount)}*" ,StrTran( sActualGraphViewSummaryTotalLeft,"$",""))
				[+] if (bMatch==FALSE)
					[ ] ReportStatus("Verify that users selected options persist for Include Reminders when Show reminders option is unchecked." , PASS ,  "Summary bar leftover didn't include reminder with amount: {iBudgetAmount} as actual leftover is: {sActualGraphViewSummaryTotalLeft} on Graph View when Show reminders option is unchecked after restarting Quicken.")
				[+] else
					[ ] ReportStatus("Verify that users selected options persist for Include Reminders when Show reminders option is unchecked." , FAIL ,  "Summary bar leftover included reminder with amount: {sActualGraphViewSummaryTotalLeft}  on Graph View when Show reminders option is unchecked after restarting Quicken.")
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
[ ] 
[+] //##########Test 7: Verify that Transaction popup include/Exclude Reminders  (Reminder Toggle) ############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test7_VerifyThatTransactionPopupIncludeExcludeReminders
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that Transaction popup include/Exclude Reminders (Reminder Toggle) 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Transaction popup include/Exclude Reminders (Reminder Toggle)
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  May 12 2014
		[ ] /////Note : TestCase not availble in updated sheet
	[ ] // ********************************************************
[ ] 
[+] testcase Test7_VerifyThatTransactionPopupIncludeExcludeReminders() appstate none
	[+] //--------------Variable Declaration-------------
		[ ] STRING sReminderOption
		[ ] iBudgetAmount=50
		[ ] sReminderOption= "Include Reminders"
		[ ] BOOLEAN bReminderMatch
		[ ] bReminderMatch=FALSE
		[ ] // Fetch 1st row from sBillWorksheet the given sheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sBillWorksheet)
		[ ] lsReminderData=lsExcelData[1]
		[ ] sPayee =lsReminderData[1]
		[ ] sAmount =lsReminderData[2]
		[ ] nAmount =VAL(sAmount)
		[ ] sAmount =trim(Str(nAmount ,4 ,2))
		[ ] ///Remove category type and parent category from the list
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] 
		[ ] lsCategoryList = lsExcelData[1]
		[ ] sCategoryType =lsCategoryList[1]
		[ ] sParentCategory=lsCategoryList[2]
		[ ] sCategory = trim(lsCategoryList[3])
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
		[+] if (iResult==PASS)
			[ ] sleep(2)
			[ ] ///Check the "Include Reminders" option on Budget>Actions>Options and verify that reminder is displayed on popup
			[ ] SelectBudgetOptionOnGraphAnnualView(sGraphView,sReminderOption)
			[ ] 
			[ ] ///Verify reminder on Graph View using Transaction popup
			[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
			[ ] iListCount= MDIClient.Budget.ListBox.GetItemCount() +1
			[+] for (iCount=1 ; iCount<=iListCount;++iCount)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
				[ ] bMatch = MatchStr("*{sCategory}*", sActual)
				[+] if (bMatch)
					[ ] QwAutoExecuteCommand("LISTBOX_SELECTROW", sHandle, Str(iCount))
					[ ] pPoint=Cursor.GetPosition()
					[ ] 
					[ ] sleep(1)
					[ ] QuickenWindow.Click(1, pPoint.x+10 ,pPoint.y+5)
					[ ] 
					[ ] ///Verify transaction poup appears
					[+] if (CalloutPopup.Exists(2))
						[ ] CalloutPopup.TextClick(sTransactionsTab)
						[ ] 
						[ ] sHandle=NULL
						[ ] iListCount=0
						[ ] sHandle= Str(CalloutPopup.ListBox.GetHandle())
						[ ] iListCount= CalloutPopup.ListBox.GetItemCount() +1
						[+] for (iCounter=1 ; iCounter<=iListCount;++iCounter)
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCounter))
							[ ] bReminderMatch = MatchStr("*{sPayee}*{sAmount}*", sActual)
							[+] if (bReminderMatch)
								[ ] break
							[ ] 
						[+] if (bReminderMatch)
							[ ] ReportStatus("Verify that Transaction popup Included Reminder when reminder option is checked.", PASS , "Transaction popup included reminder with payee: {sPayee} and amount: {sAmount} when reminder option is unchecked on Graph View.")
						[+] else
							[ ] ReportStatus("Verify that Transaction popup Included Reminder when reminder option is checked.", FAIL , "Transaction popup didn't include reminder with payee: {sPayee} and amount: {sAmount} when reminder option is uncheckedGraph View.")
						[ ] CalloutPopup.Close.Click()
						[ ] WaitForState(CalloutPopup , False ,2)
						[ ] 
					[+] else
						[ ] ReportStatus("Verify that Transaction popup include/Exclude Reminders.", FAIL , "Transaction popup didn't appear.")
					[ ] break
			[+] if(bMatch==FALSE)
				[ ] ReportStatus("Verify that Transaction popup include/Exclude Reminders." ,FAIL, "Category: {sCategory} couldn't be found.")
			[ ] 
			[ ] 
			[ ] //select annual view
			[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sAnnualView)
			[ ] ///Verify reminder on Annual View using Transaction popup
			[ ] MDIClient.Budget.ListBox.TextClick(sCategory)
			[ ] pPoint=Cursor.GetPosition()
			[ ] QuickenWindow.Click(1, pPoint.x+132 ,pPoint.y+5)
			[+] if (CalloutPopup.Exists(2))
				[ ] CalloutPopup.TextClick(sTransactionsTab)
				[ ] 
				[ ] sHandle=NULL
				[ ] iListCount=0
				[ ] sHandle= Str(CalloutPopup.ListBox.GetHandle())
				[ ] iListCount= CalloutPopup.ListBox.GetItemCount() +1
				[+] for (iCounter=1 ; iCounter<=iListCount;++iCounter)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCounter))
					[ ] bReminderMatch = MatchStr("*{sPayee}*{sAmount}*", sActual)
					[+] if (bReminderMatch)
						[ ] break
					[ ] 
				[+] if (bReminderMatch)
					[ ] ReportStatus("Verify that Transaction popup Included Reminder when reminder option is checked.", PASS , "Transaction popup included reminder with payee: {sPayee} and amount: {sAmount} when reminder option is unchecked on Annual View.")
				[+] else
					[ ] ReportStatus("Verify that Transaction popup Included Reminder when reminder option is checked.", FAIL , "Transaction popup didn't include reminder with payee: {sPayee} and amount: {sAmount} when reminder option is unchecked on Annual View.")
				[ ] CalloutPopup.Close.Click()
				[ ] WaitForState(CalloutPopup , False ,2)
				[ ] 
			[+] else
				[ ] ReportStatus("Verify that Transaction popup include/Exclude Reminders.", FAIL , "Transaction popup didn't appear.")
			[ ] 
			[ ] ///UnCheck the "Include Reminders" option on Budget>Actions>Options and verify that reminder is not displayed on popup
			[ ] QuickenWindow.SetActive()
			[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sGraphView)
			[ ] sleep(4)
			[ ] SelectBudgetOptionOnGraphAnnualView(sGraphView,sReminderOption)
			[ ] 
			[ ] ///Verify reminder on Graph View using Transaction popup
			[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
			[ ] iListCount= MDIClient.Budget.ListBox.GetItemCount() +1
			[+] for (iCount=1 ; iCount<=iListCount;++iCount)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
				[ ] bMatch = MatchStr("*{sCategory}*", sActual)
				[+] if (bMatch)
					[ ] QwAutoExecuteCommand("LISTBOX_SELECTROW", sHandle, Str(iCount))
					[ ] pPoint=Cursor.GetPosition()
					[ ] 
					[ ] sleep(1)
					[ ] QuickenWindow.Click(1, pPoint.x+10 ,pPoint.y+5)
					[ ] 
					[ ] ///Verify transaction poup appears
					[+] if (CalloutPopup.Exists(2))
						[ ] CalloutPopup.TextClick(sTransactionsTab)
						[ ] 
						[ ] sHandle=NULL
						[ ] iListCount=0
						[ ] sHandle= Str(CalloutPopup.ListBox.GetHandle())
						[ ] iListCount= CalloutPopup.ListBox.GetItemCount() +1
						[+] for (iCounter=1 ; iCounter<=iListCount;++iCounter)
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCounter))
							[ ] bReminderMatch = MatchStr("*{sPayee}*{sAmount}*", sActual)
							[+] if (bReminderMatch)
								[ ] break
							[ ] 
						[+] if (bReminderMatch)
							[ ] ReportStatus("Verify that Transaction popup Excluded Reminder when reminder option is unchecked.", FAIL , "Transaction popup included reminder with payee: {sPayee} and amount: {sAmount} when reminder option is unchecked on Graph View.")
						[+] else
							[ ] ReportStatus("Verify that Transaction popup Excluded Reminder when reminder option is unchecked.", PASS , "Transaction popup didn't include reminder with payee: {sPayee} and amount: {sAmount} when reminder option is uncheckedGraph View.")
						[ ] CalloutPopup.Close.Click()
						[ ] WaitForState(CalloutPopup , False ,2)
						[ ] 
					[+] else
						[ ] ReportStatus("Verify that Transaction popup include/Exclude Reminders.", FAIL , "Transaction popup didn't appear.")
					[ ] break
			[+] if(bMatch==FALSE)
				[ ] ReportStatus("Verify that Transaction popup include/Exclude Reminders." ,FAIL, "Category: {sCategory} couldn't be found.")
			[ ] 
			[ ] 
			[ ] //select annual view
			[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sAnnualView)
			[ ] ///Verify reminder on Annual View using Transaction popup
			[ ] MDIClient.Budget.ListBox.TextClick(sCategory)
			[ ] pPoint=Cursor.GetPosition()
			[ ] QuickenWindow.Click(1, pPoint.x+132 ,pPoint.y+5)
			[+] if (CalloutPopup.Exists(2))
				[ ] CalloutPopup.TextClick(sTransactionsTab)
				[ ] 
				[ ] sHandle=NULL
				[ ] iListCount=0
				[ ] sHandle= Str(CalloutPopup.ListBox.GetHandle())
				[ ] iListCount= CalloutPopup.ListBox.GetItemCount() +1
				[+] for (iCounter=1 ; iCounter<=iListCount;++iCounter)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCounter))
					[ ] bReminderMatch = MatchStr("*{sPayee}*{sAmount}*", sActual)
					[+] if (bReminderMatch)
						[ ] break
					[ ] 
				[+] if (bReminderMatch)
					[ ] ReportStatus("Verify that Transaction popup Excluded Reminder when reminder option is unchecked.", FAIL , "Transaction popup included reminder with payee: {sPayee} and amount: {sAmount} when reminder option is unchecked on Annual View.")
				[+] else
					[ ] ReportStatus("Verify that Transaction popup Excluded Reminder when reminder option is unchecked.", PASS , "Transaction popup didn't include reminder with payee: {sPayee} and amount: {sAmount} when reminder option is unchecked on Annual View.")
				[ ] CalloutPopup.Close.Click()
				[ ] WaitForState(CalloutPopup , False ,2)
				[ ] 
			[+] else
				[ ] ReportStatus("Verify that Transaction popup include/Exclude Reminders.", FAIL , "Transaction popup didn't appear.")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
[ ] 
[+] //##########Test 9: Verify the Totals in Annual View should include/Exclude reminder.(Reminder Toggle) ############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test9_VerifyThatAnnualViewShouldIncludeExcludeReminders
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify the Totals in Annual View should include/Exclude reminder.(Reminder Toggle)
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Totals in Annual View include/Exclude reminder.(Reminder Toggle)
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  May 12 2014
		[ ] /////Note : TestCase not availble in updated sheet
	[ ] // ********************************************************
[ ] 
[+] testcase Test9_VerifyThatAnnualViewShouldIncludeExcludeReminders() appstate none
	[+] //--------------Variable Declaration-------------
		[ ] 
		[ ] 
		[ ] INTEGER iNoTxnMonthAmount ,iRemainingMonths , iTotalMonthsBudget ,iAmountWithoutReminder ,iAmountWithReminder
		[ ] STRING sReminderOption ,sReminderAmount
		[ ] NUMBER nReminderAmount
		[ ] iBudgetAmount=50
		[ ] sReminderOption= "Include Reminders"
		[ ] BOOLEAN bReminderMatch
		[ ] bReminderMatch=FALSE
		[ ] lsTxnExcelData=NULL
		[ ] lsTxnExcelData=ReadExcelTable(sBudgetExcelsheet, sRegTransactionSheet)
		[ ] ///Spending for firs
		[ ] lsTransaction=lsTxnExcelData[1]
		[ ] iTxnAmount=VAL(lsTransaction[3])
		[ ] 
		[ ] // Fetch 1st row from sBillWorksheet the given sheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sBillWorksheet)
		[ ] lsReminderData=lsExcelData[1]
		[ ] sPayee =lsReminderData[1]
		[ ] sReminderAmount =lsReminderData[2]
		[ ] nReminderAmount =VAL(sReminderAmount)
		[ ] sReminderAmount =trim(Str(nReminderAmount ,4 ,2))
		[ ] 
		[ ] ///Remove category type and parent category from the list
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] 
		[ ] lsCategoryList = lsExcelData[1]
		[ ] sCategoryType =lsCategoryList[1]
		[ ] sParentCategory=lsCategoryList[2]
		[ ] sCategory = trim(lsCategoryList[3])
		[ ] ////Prepare data to verify
		[ ] sCurrentMonth=FormatDateTime(GetDateTime(), "m") 
		[ ] iCurrentMonth = VAL(sCurrentMonth)
		[ ] 
		[ ] iTxnMonthCount=4
		[ ] iNoTxnMonthAmount=0
		[ ] iRemainingMonths=12 - iCurrentMonth
		[ ] 
		[ ] iTotalMonthsBudget=12*iBudgetAmount
		[+] if (iCurrentMonth<=4)
			[ ] iTxnMonthCount= iCurrentMonth
			[ ] 
		[ ] 
		[ ] iAmountWithoutReminder=iTotalMonthsBudget-(iTxnMonthCount*iTxnAmount)
		[ ] iAmountWithReminder =iTotalMonthsBudget-((iTxnMonthCount*iTxnAmount) +((iRemainingMonths+1)*nReminderAmount))
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
		[+] if (iResult==PASS)
			[ ] sleep(2)
			[ ] ///Check the "Include Reminders" option on Budget>Actions>Options 
			[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sGraphView)
			[ ] sleep(2)
			[ ] SelectBudgetOptionOnGraphAnnualView(sGraphView,sReminderOption)
			[ ] 
			[ ] ///select annual view
			[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sAnnualView)
			[ ] sleep(2)
			[ ] MDIClient.Budget.AnnualViewTypeComboBox.Select("Balance only")
			[+] if (MDIClient.Budget.ShowBalanceInFutureMonthsCheckBox.Exists(2))
				[ ] MDIClient.Budget.ShowBalanceInFutureMonthsCheckBox.Check()
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] ///Get the totals for the Auto & Transport : Auto Insurance category
			[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
			[ ] iListCount= MDIClient.Budget.ListBox.GetItemCount() +1
			[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "3")
			[ ] sActualAmount=trim(StrTran(Right(sActual ,5),"@" ,""))
			[ ] 
			[ ] ///Verify the totals on balance only view when reminders are enabled
			[+] if (Str(iAmountWithReminder)==sActualAmount)
				[ ] ReportStatus("Verify the Totals in Annual View should include/Exclude reminder.(Reminder Toggle) when reminders included." , PASS , " The Totals include reminders as expected: {Str(iAmountWithReminder)}.")
			[+] else
				[ ] ReportStatus("Verify the Totals in Annual View should include/Exclude reminder.(Reminder Toggle) when reminders included." , FAIL , " The Totals included reminders NOT as expected: {Str(iAmountWithReminder)} against actual: {sActualAmount}.")
			[ ] 
			[ ] ///Uncheck the "Include Reminders" option on Budget>Actions>Options 
			[ ] SelectBudgetOptionOnGraphAnnualView(sAnnualView , sReminderOption)
			[ ] 
			[ ] ///Get the totals for the Auto & Transport : Auto Insurance category
			[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
			[ ] iListCount= MDIClient.Budget.ListBox.GetItemCount() +1
			[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "3")
			[ ] sActualAmount=trim(StrTran(Right(sActual ,5),"@" ,""))
			[ ] ////Verify the totals on balance only view when reminders are disabled
			[+] if (Str(iAmountWithoutReminder) == sActualAmount)
				[ ] ReportStatus("Verify the Totals in Annual View should include/Exclude reminder.(Reminder Toggle) when reminders excluded." , PASS , " The Totals exclude reminders as expected: {Str(iAmountWithoutReminder)}.")
			[+] else
				[ ] ReportStatus("Verify the Totals in Annual View should include/Exclude reminder.(Reminder Toggle) when reminder excluded." , FAIL , " The Totals exclude reminders NOT as expected: {Str(iAmountWithoutReminder)} against actual: {sActualAmount}.")
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
[ ] 
[+] //##########Test 1: Total of the parent category should be the sum of all sub-categories (including "Everything Else and Other"). #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test1_VerifyThatTotalOfTheParentCatShouldBeSumOfTheAllSubCatsIncludingEverythingElseAndOther
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that Total of the parent category should be the sum of all sub-categories (including "Everything Else and Other")
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Total of the parent category is the sum of all sub-categories (including "Everything Else and Other")
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  May 16  2014
		[ ] //
	[ ] // ********************************************************
[ ] 
[+] testcase Test1_VerifyThatTotalOfTheParentCatShouldBeSumOfTheAllSubCatsIncludingEverythingElseAndOther() appstate none
	[+] //--------------Variable Declaration-------------
		[ ] 
		[ ] 
		[ ] ///Remove category type and parent category from the list
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] 
		[ ] lsCategoryList = lsExcelData[1]
		[ ] sCategoryType =lsCategoryList[1]
		[ ] sParentCategory=lsCategoryList[2]
		[ ] sCategory = trim(lsCategoryList[3])
		[ ] ListDelete(lsCategoryList ,1)
		[ ] ListDelete(lsCategoryList ,1)
		[ ] //Add Other category to Catgory list
		[ ] ListAppend(lsCategoryList ,sOther)
		[ ] iBudgetAmount=50
		[ ] ////Prepare data to verify
		[ ] sCurrentMonth=FormatDateTime(GetDateTime(), "m") 
		[+] for( iCounter=1; iCounter <=ListCount (lsCategoryList) ; iCounter++)
			[+] if (lsCategoryList[iCounter]==NULL)
				[ ] ListDelete (lsCategoryList ,iCounter)
				[ ] iCounter--
				[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iResult=DeleteCustomCategoryGroup(sCustomCatGroup)
		[+] if (iResult==PASS)
			[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
			[+] if (iResult==PASS)
				[ ] iResult=DeleteBudget()
				[+] if (iResult==PASS)
					[ ] iResult=AddBudget(sBudgetName)
					[+] if (iResult==PASS)
						[ ] ReportStatus("Verify budget gets added.", PASS, "Budget: {sBudgetName} has been added.")
						[ ] QuickenWindow.SetActive()
						[ ] 
						[ ] //Add Other category to budget
						[ ] SelectOneCategoryToBudget(sCategoryType ,sOther)
						[ ] //Set RollupOn on Graph View
						[ ] SelectBudgetOptionOnGraphAnnualView(sGraphView,"Rollup")
						[ ] 
						[+] for( iCounter=1; iCounter <=ListCount (lsCategoryList) ; iCounter++)
							[+] if (lsCategoryList[iCounter]==NULL)
								[ ] break
							[ ] sCategory=trim(lsCategoryList[iCounter])
							[ ] MDIClient.Budget.ListBox.TextClick(sCategory)
							[ ] MDIClient.Budget.ListBox.Amount.SetText(str(iBudgetAmount))
							[ ] sleep(0.5)
							[ ] MDIClient.Budget.ListBox.Amount.TypeKeys(KEY_ENTER)
							[ ] sleep(1)
							[ ] 
						[ ] 
						[ ] iTotalBudget =ListCount (lsCategoryList)*iBudgetAmount
						[ ] QuickenWindow.SetActive()
						[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
						[ ] iListCount= MDIClient.Budget.ListBox.GetItemCount() +1
						[+] for(iCount= 0; iCount <= iListCount;  iCount++)
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
							[ ] bMatch = MatchStr("*{sParentCategory}*{iTotalBudget}*", sActual)
							[+] if(bMatch)
								[ ] break
						[ ] 
						[+] if (bMatch)
							[ ] ReportStatus("Verify total of the parent category should be the sum of all sub-categories including Everything Else and Other." , PASS , "Total of the parent category is:{iTotalBudget} sum of all sub-categories including Everything Else and Other on graph view.")
						[+] else
							[ ] ReportStatus("Verify total of the parent category should be the sum of all sub-categories including Everything Else and Other." , FAIL , "Total of the parent category actual: {sActual} is NOT as expected: {iTotalBudget} sum of all sub-categories including Everything Else and Other on graph view.")
						[ ] 
						[ ] 
						[ ] ///Verfiy budget total on annual view
						[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sAnnualView)
						[ ] QuickenWindow.SetActive()
						[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
						[ ] iListCount= MDIClient.Budget.ListBox.GetItemCount() +1
						[+] for(iCount= 0; iCount <= iListCount;  iCount++)
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
							[ ] bMatch = MatchStr("*{iTotalBudget}*", sActual)
							[+] if(bMatch)
								[ ] break
						[ ] 
						[+] if (bMatch)
							[ ] ReportStatus("Verify total of the parent category should be the sum of all sub-categories including Everything Else and Other." , PASS , "Total of the parent category is:{iTotalBudget} sum of all sub-categories including Everything Else and Other on Annual view.")
						[+] else
							[ ] ReportStatus("Verify total of the parent category should be the sum of all sub-categories including Everything Else and Other." , FAIL , "Total of the parent category actual: {sActual} is NOT as expected: {iTotalBudget} sum of all sub-categories including Everything Else and Other on Annual view.")
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify budget gets added.", FAIL, "Budget: {sBudgetName} couldn't be added.")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify budget gets deleted.", FAIL, "Budget: {sBudgetName} couldn't be deleted.")
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
		[+] else
			[ ] ReportStatus("Verify delete custom category group." , FAIL , "Custom category group couldn't be deleted.")
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
[ ] 
[+] //##########Test 3: "Other" categories in budget reports to be displayed as "Other" under the total categories heading. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test3_VerifyThatOtherCatInBudgetReportsDisplayedAsOtherUnderTheTotalCats
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that "Other" categories in budget reports to be displayed as "Other" under the total categories heading
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If "Other" categories in budget reports are displayed as "Other" under the total categories heading
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  May 16  2014
		[ ] //
	[ ] // ********************************************************
[ ] 
[+] testcase Test3_VerifyThatOtherCatInBudgetReportsDisplayedAsOtherUnderTheTotalCats() appstate none
	[+] //--------------Variable Declaration-------------
		[ ] 
		[ ] 
		[ ] ///Remove category type and parent category from the list
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] 
		[ ] lsCategoryList = lsExcelData[1]
		[ ] sCategoryType =lsCategoryList[1]
		[ ] sParentCategory=lsCategoryList[2]
		[ ] sCategory = trim(lsCategoryList[3])
		[ ] ListDelete(lsCategoryList ,1)
		[ ] ListDelete(lsCategoryList ,1)
		[ ] //Add Other category to Catgory list
		[ ] ListAppend(lsCategoryList ,sOther)
		[ ] iBudgetAmount=50
		[ ] ////Prepare data to verify
		[ ] sCurrentMonth=FormatDateTime(GetDateTime(), "m") 
		[+] for( iCounter=1; iCounter <=ListCount (lsCategoryList) ; iCounter++)
			[+] if (lsCategoryList[iCounter]==NULL)
				[ ] ListDelete (lsCategoryList ,iCounter)
				[ ] iCounter--
				[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //Select Current Budget report on Graph View 
		[ ] SelectBudgetReportOnGraphView(sREPORT_CURRENT_BUDGET)
		[+] if (CurrentBudget.Exists(2))
			[ ] CurrentBudget.SetActive()
			[ ] CurrentBudget.Maximize()
			[ ] iCatCount=1
			[ ] sHandle= Str(CurrentBudget.ListBox.GetHandle())
			[ ] iListCount =CurrentBudget.ListBox.GetItemCount() 
			[+] for(iCount= 1; iCount <= iListCount;  iCount++)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount-1))
				[ ] bMatch = MatchStr("*{sParentCategory}*", sActual)
				[+] if (bMatch)
					[ ] iCounter = iCount +1
					[+] for (iCount= iCounter; iCount < iCounter+ListCount(lsCategoryList);  iCount++)
						[ ] 
						[ ] //// iCatCount is used to iterate the category list
						[ ] 
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount-1))
						[ ] bMatch = MatchStr("*{lsCategoryList[iCatCount]}*", sActual)
						[+] if (bMatch)
							[ ] ReportStatus("Other categories in budget reports to be displayed as Other under the total categories heading.", PASS ,"Category:{lsCategoryList[iCatCount]} in report: {sREPORT_CURRENT_BUDGET} found in hierarchical order.")
						[+] else
							[ ] ReportStatus("Other categories in budget reports to be displayed as Other under the total categories heading.", FAIL , " Category:{lsCategoryList[iCatCount]} didn't display as expected under parent: {sParentCategory}, actual category is: {sActual} in report: {sREPORT_CURRENT_BUDGET}.") 
						[ ] iCatCount++
					[ ] break
			[+] if (bMatch==FALSE)
				[ ] ReportStatus("Other categories in budget reports to be displayed as Other under the total categories heading.", FAIL ,"Parent Category: {sParentCategory} on report: {sREPORT_CURRENT_BUDGET} couldn't be found.")
			[ ] CurrentBudget.SetActive()
			[ ] CurrentBudget.Close()
			[ ] WaitForState(CurrentBudget , False ,2)
		[+] else
			[ ] ReportStatus("Verify report: {sREPORT_CURRENT_BUDGET} on budget Graph View.", FAIL , " {sREPORT_CURRENT_BUDGET} on budget Graph View didn't appear.") 
		[ ] ///Select Historical Budget report on Graph View
		[ ] 
		[ ] SelectBudgetReportOnGraphView(sREPORT_HISTORICAL_BUDGET)
		[+] if (HistoricalBudget.Exists(2))
			[ ] HistoricalBudget.SetActive()
			[ ] HistoricalBudget.Maximize()
			[ ] iCatCount=1
			[ ] sHandle= Str(HistoricalBudget.ListBox.GetHandle())
			[ ] iListCount =HistoricalBudget.ListBox.GetItemCount() 
			[+] for(iCount= 1; iCount <= iListCount;  iCount++)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount-1))
				[ ] bMatch = MatchStr("*{sParentCategory}*", sActual)
				[+] if (bMatch)
					[ ] iCounter = iCount +1
					[+] for (iCount= iCounter; iCount < iCounter+ListCount(lsCategoryList);  iCount++)
						[ ] 
						[ ] //// iCatCount is used to iterate the category list
						[ ] 
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount-1))
						[ ] bMatch = MatchStr("*{lsCategoryList[iCatCount]}*", sActual)
						[+] if (bMatch)
							[ ] ReportStatus("Other categories in budget reports to be displayed as Other under the total categories heading.", PASS ,"Category: {lsCategoryList[iCatCount]} in report: {sREPORT_HISTORICAL_BUDGET} found in hierarchical order.")
						[+] else
							[ ] ReportStatus("Other categories in budget reports to be displayed as Other under the total categories heading.", FAIL , " Category:{lsCategoryList[iCatCount]} didn't display as expected under parent: {sParentCategory}, actual category is: {sActual} in report: {sREPORT_HISTORICAL_BUDGET}.") 
						[ ] iCatCount++
					[ ] break
			[+] if (bMatch==FALSE)
				[ ] ReportStatus("Other categories in budget reports to be displayed as Other under the total categories heading.", FAIL ,"Parent Category: {sParentCategory} couldn't be found on report: {sREPORT_HISTORICAL_BUDGET} .")
			[ ] HistoricalBudget.SetActive()
			[ ] HistoricalBudget.Close()
			[ ] WaitForState(HistoricalBudget , False ,2)
		[+] else
			[ ] ReportStatus("Verify report: {sREPORT_CURRENT_BUDGET} on budget Graph View.", FAIL , " {sREPORT_CURRENT_BUDGET} on budget Graph View didn't appear.") 
			[ ] 
			[ ] 
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
[ ] 
[+] //##########Test 6: Collapse/expand a parents sub-categories when displaying both parents and sub-categories. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test6_VerifyCollapsExpandFeatureWhenDisplayingBothParentsAndSubCategories
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that Collapse/expand a parent's sub-categories when displaying both parents and sub-categories.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Collapse/expand button of a parent collapses/expands subcategories
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  May 16  2014
		[ ] //
	[ ] // ********************************************************
[ ] 
[+] testcase Test6_VerifyCollapsExpandFeatureWhenDisplayingBothParentsAndSubCategories() appstate none
	[+] //--------------Variable Declaration-------------
		[ ] 
		[ ] 
		[ ] ///Remove category type and parent category from the list
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] 
		[ ] lsCategoryList = lsExcelData[1]
		[ ] sCategoryType =lsCategoryList[1]
		[ ] sParentCategory=lsCategoryList[2]
		[ ] sCategory = trim(lsCategoryList[3])
		[ ] ListDelete(lsCategoryList ,1)
		[ ] ListDelete(lsCategoryList ,1)
		[ ] //Add Other category to Catgory list
		[ ] ListAppend(lsCategoryList ,sOther)
		[ ] iBudgetAmount=50
		[ ] ////Prepare data to verify
		[ ] sCurrentMonth=FormatDateTime(GetDateTime(), "m") 
		[+] for( iCounter=1; iCounter <=ListCount (lsCategoryList) ; iCounter++)
			[+] if (lsCategoryList[iCounter]==NULL)
				[ ] ListDelete (lsCategoryList ,iCounter)
				[ ] iCounter--
				[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[+] do
			[ ] MDIClient.Budget.ListBox.TextClick(Upper(sCategoryType))
			[ ] ReportStatus("Verify Collapse/expand button of a parent collapses/expands subcategories" , PASS, "Category Type: {sCategoryType} displayed as expected on Graph View.")
			[ ] 
			[ ] //Verify that Parent Category is hidden when category type is collapsed
			[+] do
				[ ] MDIClient.Budget.ListBox.TextClick(sParentCategory)
				[ ] ReportStatus("Verify that Parent Category is hidden when category type is collapsed" , FAIL, "Parent Category: {sParentCategory} didn't hide under the Category Type: {sCategoryType} on Graph View.")
				[ ] 
			[+] except
				[ ] ReportStatus("Verify that Parent Category displayed on Graph View." , PASS, "Parent Category: {sParentCategory} displayed under the Category Type: {sCategoryType} on Graph View.")
				[ ] MDIClient.Budget.ListBox.TextClick(Upper(sCategoryType))
				[+] for each sCategory in lsCategoryList
					[+] do
						[+] if (sCategory==NULL)
							[ ] break
						[ ] sExpectedCategory="{sCategory}"
						[+] MDIClient.Budget.ListBox.TextClick(sExpectedCategory)
							[ ] ReportStatus("Verify that Sub Category is displayed on Graph View when parent category is expaned." , PASS, "Sub Category: {sExpectedCategory} displayed on Graph View.")
						[ ] 
					[+] except
							[ ] ReportStatus("Verify that Sub Category is displayed on Graph View when parent category is expaned." , FAIL, "Sub Category: {sExpectedCategory} didn't display on Graph View.")
						[ ] 
				[ ] MDIClient.Budget.ListBox.TextClick(sParentCategory)
				[ ] 
				[ ] 
				[ ] ///Verify sub-categories not displayed when parent category collapsed
				[ ] 
				[+] for each sCategory in lsCategoryList
					[+] do
						[+] if (sCategory==NULL)
							[ ] break
						[ ] sExpectedCategory="{sCategory}"
						[+] MDIClient.Budget.ListBox.TextClick(sExpectedCategory)
							[ ] ReportStatus("Verify that Sub Category is NOT displayed on Graph View when parent category is collapsed." , FAIL, "Sub Category: {sExpectedCategory} displayed on Graph View when parent category is collapsed Defect QW-3111.")
					[+] except
							[ ] ReportStatus("Verify that Sub Category is NOT displayed on Graph View when parent category is collapsed." , PASS, "Sub Category: {sExpectedCategory} didn't display on Graph View when parent category is collapsed.")
						[ ] 
				[ ] 
				[ ] ////Expand the parent category
				[ ] MDIClient.Budget.ListBox.TextClick(sParentCategory)
			[ ] 
		[+] except
			[ ] ReportStatus("Verify that Category Type  displayed as expected on Annual View." , FAIL, "Category Type: {sCategoryType} didn't display on Annual View.")
			[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
[ ] 
[ ] 
[+] //##########Test 8: Annual budgeting available on Budget page. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test8_VerifyAnnualBudgetingIsAvailableOnBudgetPage
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that Annual budgeting available on Budget page.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Annual budgeting available on Budget page
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  May 19  2014
		[ ] //
	[ ] // ********************************************************
[ ] 
[+] testcase Test8_VerifyAnnualBudgetingIsAvailableOnBudgetPage() appstate none
	[ ] //--------------Variable Declaration-------------
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
		[+] if (iResult==PASS)
			[ ] 
			[ ] 
			[+] if (MDIClient.Budget.BudgetViewTypeComboBox.FindItem(lsBudgetViews[2])==2)
				[ ] ReportStatus("Verify Annual budgeting is available on Budget page" , PASS ,"Annual budgeting is available on Budget page.")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Annual budgeting is available on Budget page" , FAIL ,"Annual budgeting is NOT available on Budget page.")
		[+] else
			[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
[ ] 
[+] //##########Test 9: Annual view display content. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test9_VerifyAnnualViewDisplaysContentAsExpected
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that Annual view displays content as expected.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Annual view displays content as expected
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  May 19  2014
		[ ] //
	[ ] // ********************************************************
[ ] 
[+] testcase Test9_VerifyAnnualViewDisplaysContentAsExpected() appstate none
	[ ] //--------------Variable Declaration-------------
	[ ] STRING sBudget ,sBalance
	[ ] sBudget="BUDGET"
	[ ] sActual="ACTUAL"
	[ ] sBalance ="BALANCE"
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
		[+] if (iResult==PASS)
			[ ] ////select annual view
			[ ] 
			[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sAnnualView)
			[ ] sleep(2)
			[ ] ///select details view on annual view
			[ ] MDIClient.Budget.AnnualViewTypeComboBox.Select("Details")
			[ ] sleep(2)
			[ ] //Verify the BUDGET coulmn for a month
			[+] do
				[ ] MDIClient.Budget.ListViewer.TextClick(sBudget)
				[ ] ReportStatus("Verify that Annual view displays content as expected." , PASS, "On Details view of Annual view has the BUDGET column.")
				[ ] 
			[+] except
				[ ] ReportStatus("Verify that Annual view displays content as expected." , FAIL, "On Details view of Annual view doesn't have the BUDGET column.")
			[ ] //Verify the ACTUAL coulmn for a month
			[+] do
				[ ] MDIClient.Budget.ListViewer.TextClick(sActual)
				[ ] ReportStatus("Verify that Annual view displays content as expected." , PASS, "On Details view of Annual view has the ACTUAL column.")
				[ ] 
			[+] except
				[ ] ReportStatus("Verify that Annual view displays content as expected." , FAIL, "On Details view of Annual view doesn't have the ACTUAL column.")
			[ ] //Verify the BALANCE coulmn for a month
			[+] do
				[ ] MDIClient.Budget.ListViewer.TextClick(sBalance)
				[ ] ReportStatus("Verify that Annual view displays content as expected." , PASS, "On Details view of Annual view has the BALANCE column.")
				[ ] 
			[+] except
				[ ] ReportStatus("Verify that Annual view displays content as expected." , FAIL, "On Details view of Annual view doesn't have the BALANCE column.")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
[ ] 
[ ] 
[+] //##########Test 10: Graph view/Annual View status after re-launching Quicken. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test10_VerifyAnnualViewStatusAfterRelaunchingQuicken
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that Graph view/Annual View status after re-launching Quicken.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Graph view/Annual View status after re-launching Quicken is set to default to current year
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  May 20  2014
		[ ] //
	[ ] // ********************************************************
[ ] 
[+] testcase Test10_VerifyAnnualViewStatusAfterRelaunchingQuicken() appstate none
	[+] //--------------Variable Declaration-------------
		[ ] STRING sExpectedYear
		[ ] sExpectedYear=FormatDateTime(GetDateTime(), "yyyy") 
		[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
		[+] if (iResult==PASS)
			[ ] ////select annual view
			[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sAnnualView)
			[ ] sleep(2)
			[ ] ////Create budegt for previous year
			[ ] MDIClient.Budget.BackWardMonthButton.Click()
			[+] if (DlgAddABudgetForNextOrPreviousYear.Exists(5))
				[ ] ReportStatus("Verify the Budget can be extended to previous year." , PASS, "Previous year budget has been created.")
				[ ] DlgAddABudgetForNextOrPreviousYear.SetActive()
				[ ] sActual =DlgAddABudgetForNextOrPreviousYear.GetProperty("Caption")
				[ ] DlgAddABudgetForNextOrPreviousYear.RadioListCopyThisYearsCategoriesAndActualsAsBudget.Select(2)
				[ ] DlgAddABudgetForNextOrPreviousYear.OKButton.Click()
				[ ] WaitForState(DlgAddABudgetForNextOrPreviousYear , FALSE ,5)
				[ ] 
				[ ] ///Restart Quicken
				[ ] LaunchQuicken()
				[+] if(QuickenWindow.Exists(5))
					[ ] QuickenWindow.SetActive()
					[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
					[ ] sleep(2)
					[+] if (iResult==PASS)
						[ ] QuickenWindow.SetActive()
						[ ] 
						[ ] //Verify budget year after restarting Quicken
						[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sGraphView)
						[ ] //On Graph View
						[ ] sYear=MDIClient.Budget.CurrentMonthStaticText.GetText()
						[ ] sYear =Right(sYear ,4)
						[+] if (trim(sYear)==sExpectedYear)
							[ ] ReportStatus("Verify Graph view/Annual View status after re-launching Quicken is set to default to current year. ", PASS , "Budget is set to default current year: {sExpectedYear} on Graph View.") 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Graph view/Annual View status after re-launching Quicken is set to default to current year. ", FAIL , "Budget couldn't be set to default current year: {sExpectedYear}, actual year is: {sYear} on Graph View.") 
						[ ] 
						[ ] //On Annual View
						[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sAnnualView)
						[ ] QuickenWindow.SetActive()
						[ ] sYear=MDIClient.Budget.CurrentMonthStaticText.GetText()
						[+] if (trim(sYear)==sExpectedYear)
							[ ] ReportStatus("Verify Graph view/Annual View status after re-launching Quicken is set to default to current year. ", PASS , "Budget is set to default current year: {sExpectedYear} on Annual View.") 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Graph view/Annual View status after re-launching Quicken is set to default to current year. ", FAIL , "Budget couldn't be set to default current year: {sExpectedYear}, actual year is: {sYear} on Annual View.") 
					[+] else
						[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
				[+] else
					[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
			[+] else
				[ ] ReportStatus("Verify the Budget can be extended to previous year." , FAIL, "Dialog:{sActual} didn't appear.")
		[+] else
			[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
[ ] 
[ ] 
[+] //##########Test 11: Summary bar status for income category transactions. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test11_VerifySummaryBarStatusForIncomeTransactions
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify Summary bar status for income category transactions.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Summary bar status for income category transactions is accurate
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  May 21  2014
		[ ] //
	[ ] // ********************************************************
[ ] 
[+] testcase Test11_VerifySummaryBarStatusForIncomeTransactions() appstate none
	[+] //--------------Variable Declaration-------------
		[ ] INTEGER iExpenseTotalAmount ,iIncomeBudgetAmount ,iReminderAmount ,iExpenseTxnAmount
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] sAccountName= lsAddAccount[2]
		[ ] 
		[ ] ///Get categories from excel
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] //Get income category
		[ ] lsCategoryList = lsExcelData[3]
		[ ] sCategoryType =lsCategoryList[1]
		[ ] sCategory=lsCategoryList[2]
		[ ] ///Get transactions from excel
		[ ] lsTxnExcelData=NULL
		[ ] lsTxnExcelData=ReadExcelTable(sBudgetExcelsheet, sRegTransactionSheet)
		[ ] 
		[ ] iTxnAmount=0
		[ ] iExpenseTxnAmount=0
		[ ] iIncomeBudgetAmount=200
		[ ] //Sum up the expense category transactions
		[+] for (iCount=1 ; iCount<=3 ; iCount++)
			[ ] lsTransaction=lsTxnExcelData[iCount]
			[ ] iTxnAmount=VAL(lsTransaction[3])
			[ ] iExpenseTxnAmount=iExpenseTxnAmount +iTxnAmount
		[ ] //Get Reminder amount
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sBillWorksheet)
		[ ] lsReminderData=lsExcelData[1]
		[ ] iReminderAmount =VAL(lsReminderData[2])
		[ ] iExpenseTotalAmount =iExpenseTxnAmount +iReminderAmount
		[ ] 
		[ ] ///Get Income transaction
		[ ] lsTransaction=lsTxnExcelData[4]
		[ ] 
		[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] iResult= SelectAccountFromAccountBar(sAccountName, ACCOUNT_BANKING)
		[+] if (iResult==PASS)
			[ ] AddCheckingTransaction(lsTransaction[1],lsTransaction[2],lsTransaction[3],sDate,lsTransaction[5],lsTransaction[6],lsTransaction[7],lsTransaction[8])
			[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
			[+] if (iResult==PASS)
				[ ] sleep(2)
				[ ] QuickenWindow.SetActive()
				[ ] iResult=SelectOneCategoryToBudget(sCategoryType ,sCategory)
				[+] if (iResult==PASS)
					[ ] 
					[ ] QuickenWindow.SetActive()
					[ ] ///add budget to income category
					[ ] MDIClient.Budget.ListBox.TextClick(sCategory)
					[ ] MDIClient.Budget.ListBox.Amount.SetText(Str(iIncomeBudgetAmount))
					[ ] MDIClient.Budget.ListBox.TypeKeys(KEY_ENTER)
					[ ] 
					[ ] ///Verify Income transaction displayed on Graph View Summary Total Savings
					[ ] sActualSummaryTotalSavings = MDIClient.Budget.GraphViewSummaryTotalSavings.GetProperty("Caption")
					[ ] sActualSummaryTotalSavings =trim(StrTran(sActualSummaryTotalSavings ,"$" ,""))
					[ ] sExpectedAnnualViewSavings =str(iIncomeBudgetAmount - iExpenseTotalAmount)
					[+] if (sExpectedAnnualViewSavings==sActualSummaryTotalSavings)
						[ ] ReportStatus("Verify Summary bar status for income category transactions." , PASS , "Income displayed on the Graph View Summary Total Savings: {sActualSummaryTotalSavings}.")
					[+] else
						[ ] ReportStatus("Verify Summary bar status for income category transactions." , FAIL , "Income didn't display as actual Total Savings: {sActualSummaryTotalSavings} is not as expected: {sExpectedAnnualViewSavings}.")
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify category added to the budget.", FAIL , "Category: {sParentCategory} of type: {sCategoryType} couldn't be added to the budget.") 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
			[ ] 
		[+] else
			[ ] ReportStatus("Verfiy account: {sAccountName} selected." , FAIL ,"Account: {sAccountName} coulkdn't be selected.")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
[ ] 
[ ] 
[+] //##########Test 12: Total left/under/over budget amount calculation for sub-categories displayed against their parent category. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test12_VerifyTotalLeftUnderOverBudgetAmountCalculationForSubCategoryTransactions
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify Total left/under/over budget amount calculation for sub-categories displayed against their parent category
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Total left/under/over budget amount calculation for sub-categories displayed against their parent category is correct
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  May 22  2014
		[ ] //
	[ ] // ********************************************************
[ ] 
[+] testcase Test12_VerifyTotalLeftUnderOverBudgetAmountCalculationForSubCategoryTransactions() appstate none
	[+] //--------------Variable Declaration-------------
		[ ] INTEGER iExpenseTotalAmount ,iIncomeBudgetAmount ,iReminderAmount ,iExpenseTxnAmount ,iIncomeTxnAmount ,iExpenseCatBudgetAmount
		[ ] INTEGER iTotalExpenseBudgetAmount
		[ ] STRING sUnderAmountForIncome ,sOverBudgetAmount ,sLeftBudgetAmount ,sOver ,sLeft ,sUnder
		[ ] sOver ="over"
		[ ] sLeft ="left"
		[ ] sUnder="under"
		[ ] 
		[ ] ///Get transactions from excel
		[ ] lsTxnExcelData=NULL
		[ ] lsTxnExcelData=ReadExcelTable(sBudgetExcelsheet, sRegTransactionSheet)
		[ ] lsTransaction=lsTxnExcelData[4]
		[ ] iIncomeTxnAmount =VAL(lsTransaction[3])
		[ ] iIncomeBudgetAmount=200
		[ ] //Calculate under amount for Income category 
		[ ] sUnderAmountForIncome =Str( iIncomeBudgetAmount - iIncomeTxnAmount)
		[ ] 
		[ ] iTxnAmount=0
		[ ] iExpenseTxnAmount=0
		[ ] 
		[ ] //Sum up the expense category transactions
		[+] for (iCount=1 ; iCount<=3 ; iCount++)
			[ ] lsTransaction=lsTxnExcelData[iCount]
			[ ] iTxnAmount=VAL(lsTransaction[3])
			[ ] iExpenseTxnAmount=iExpenseTxnAmount +iTxnAmount
		[ ] //Get Reminder amount
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sBillWorksheet)
		[ ] lsReminderData=lsExcelData[1]
		[ ] iReminderAmount =VAL(lsReminderData[2])
		[ ] iExpenseTotalAmount =iExpenseTxnAmount +iReminderAmount
		[ ] ///Get categories from excel
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] //Get income category
		[ ] lsCategoryList = lsExcelData[3]
		[ ] sCategoryType =lsCategoryList[1]
		[ ] sCategory=lsCategoryList[2]
		[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
		[+] if (iResult==PASS)
			[ ] ////Select Graph view
			[ ] sleep(2)
			[ ] QuickenWindow.SetActive()
			[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sGraphView)
			[ ] 
			[ ] ///Verify left amount for the income category
			[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
			[ ] iListCount= MDIClient.Budget.ListBox.GetItemCount() 
			[ ] 
			[+] for (iCount=0 ; iCount<=iListCount;++iCount)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
				[ ] bMatch = MatchStr("*{sCategory}*{sUnderAmountForIncome}*{sUnder}*{Str(iIncomeBudgetAmount)}*", sActual)
				[+] if (bMatch)
					[ ] break
				[ ] 
			[+] if (bMatch)
				[ ] ReportStatus("Verify under amount for Income category in budget." , PASS ,"The total under amount:{sUnderAmountForIncome} for Income Category: {sCategory} is as expected.")
			[+] else
				[ ] ReportStatus("Verify under amount for Income category in budget." , FAIL ,"The total under actual amount:{sActual} for Income Category: {sCategory} is NOT as expected: {sUnderAmountForIncome}.")
			[ ] 
			[ ] 
			[ ] //Get the expense categories
			[ ] lsCategoryList = lsExcelData[1]
			[ ] sCategoryType =lsCategoryList[1]
			[ ] sParentCategory=lsCategoryList[2]
			[ ] sCategory = trim(lsCategoryList[3])
			[ ] ListDelete(lsCategoryList ,1)
			[ ] ListDelete(lsCategoryList ,1)
			[ ] ////Prepare data to verify
			[ ] 
			[+] for( iCounter=1; iCounter <=ListCount (lsCategoryList) ; iCounter++)
				[+] if (lsCategoryList[iCounter]==NULL)
					[ ] ListDelete (lsCategoryList ,iCounter)
					[ ] iCounter--
					[ ] 
			[ ] 
			[ ] ///Verify Over amount for the expense category
			[ ] iExpenseCatBudgetAmount=30
			[ ] ///Set the budget values for the Expense categories
			[ ] iListCount=ListCount(lsCategoryList)
			[+] for (iCount=1 ; iCount<=iListCount;++iCount)
				[ ] MDIClient.Budget.ListBox.TextClick(trim(lsCategoryList[iCount]))
				[ ] MDIClient.Budget.ListBox.Amount.SetText(Str(iExpenseCatBudgetAmount))
				[ ] MDIClient.Budget.ListBox.Amount.TypeKeys(KEY_ENTER)
				[ ] 
				[ ] 
			[ ] 
			[ ] //Calculate the total expense budget category amount
			[ ] 
			[ ] iTotalExpenseBudgetAmount =iListCount*iExpenseCatBudgetAmount
			[ ] ///Verify Over amount for the expense category
			[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
			[ ] iListCount= MDIClient.Budget.ListBox.GetItemCount() 
			[ ] sOverBudgetAmount = str( iExpenseTotalAmount -iTotalExpenseBudgetAmount)
			[+] for (iCount=0 ; iCount<=iListCount;++iCount)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
				[ ] bMatch = MatchStr("*{sParentCategory}*{sOverBudgetAmount}*{sOver}*{Str(iTotalExpenseBudgetAmount)}*", sActual)
				[+] if (bMatch)
					[ ] break
				[ ] 
			[+] if (bMatch)
				[ ] ReportStatus("Verify Over amount for expense category in budget." , PASS ,"The total Over amount:{sOverBudgetAmount} for Parent Expense Category: {sParentCategory} is as expected.")
			[+] else
				[ ] ReportStatus("Verify Over amount for expense category in budget." , FAIL ,"The total Over actual amount:{sActual} for Parent Expense Category: {sParentCategory} is NOT as expected: {sOverBudgetAmount}.")
			[ ] 
			[ ] ///Verify Left amount for the expense category
			[ ] iExpenseCatBudgetAmount=50
			[ ] ///Set the budget values for the Expense categories
			[ ] iListCount=ListCount(lsCategoryList)
			[+] for (iCount=1 ; iCount<=iListCount;++iCount)
				[ ] MDIClient.Budget.ListBox.TextClick(trim(lsCategoryList[iCount]))
				[ ] MDIClient.Budget.ListBox.Amount.SetText(Str(iExpenseCatBudgetAmount))
				[ ] MDIClient.Budget.ListBox.Amount.TypeKeys(KEY_ENTER)
				[ ] 
				[ ] 
			[ ] 
			[ ] //Calculate the total expense budget category amount
			[ ] 
			[ ] iTotalExpenseBudgetAmount =iListCount*iExpenseCatBudgetAmount
			[ ] ///Verify Over amount for the expense category
			[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
			[ ] iListCount= MDIClient.Budget.ListBox.GetItemCount() 
			[ ] sLeftBudgetAmount = str(iTotalExpenseBudgetAmount - iExpenseTotalAmount)
			[+] for (iCount=0 ; iCount<=iListCount;++iCount)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
				[ ] bMatch = MatchStr("*{sParentCategory}*{sLeftBudgetAmount}*{sLeft}*{Str(iTotalExpenseBudgetAmount)}*", sActual)
				[+] if (bMatch)
					[ ] break
				[ ] 
			[+] if (bMatch)
				[ ] ReportStatus("Verify Left amount for expense category in budget." , PASS ,"The total Left amount:{sLeftBudgetAmount} for Parent Expense Category: {sParentCategory} is as expected.")
			[+] else
				[ ] ReportStatus("Verify Left amount for expense category in budget." , FAIL ,"The total Left actual amount:{sActual} for Parent Expense Category: {sParentCategory} is NOT as expected: {sLeftBudgetAmount}.")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
[ ] 
[ ] 
[+] //##########Test 15: Summary bar status. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test15_VerifySummaryBarStatusWhenNoCategoriesAddedToBudget
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify Summary bar status when no categories added to budget
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Summary bar status is 0 for all the labels when no categories added to budget
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  May 22  2014
		[ ] //
	[ ] // ********************************************************
[ ] 
[+] testcase Test15_VerifySummaryBarStatusWhenNoCategoriesAddedToBudget() appstate none
	[+] //--------------Variable Declaration-------------
		[ ] STRING sZero
		[ ] sZero ="$0"
		[ ] ///Get categories from excel
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] //Get income category
		[ ] lsCategoryList = lsExcelData[1]
		[ ] sCategoryType =lsCategoryList[1]
		[ ] sCategory=lsCategoryList[2]
		[ ] ///remove Category type and parent category from the list 
		[ ] ListDelete(lsCategoryList ,1)
		[ ] ListDelete(lsCategoryList ,1)
		[+] for( iCounter=1; iCounter <=ListCount (lsCategoryList) ; iCounter++)
			[+] if (lsCategoryList[iCounter]==NULL)
				[ ] ListDelete (lsCategoryList ,iCounter)
				[ ] iCounter--
				[ ] 
		[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
		[+] if (iResult==PASS)
			[ ] 
			[ ] iResult=DeleteBudget()
			[+] if (iResult==PASS)
				[ ] iResult=AddBudget(sBudgetName)
				[+] if (iResult==PASS)
					[ ] ReportStatus("Verify budget gets added.", PASS, "Budget: {sBudgetName} has been added.")
					[ ] ////Select Graph view
					[ ] QuickenWindow.SetActive()
					[ ] SelectBudgetOptionOnGraphAnnualView(sGraphView ,"Rollup")
					[ ] //Remove auto budgeted expense categories
					[+] for( iCounter=1; iCounter <=ListCount (lsCategoryList) ; iCounter++)
						[ ] sCategory=NULL
						[ ] sCategory=lsCategoryList[iCounter]
						[ ] RemoveCategoryFromBudget(sCategory)
					[ ] 
					[ ] 
					[ ] ///Verify Summary Bar Status without adding the categories to budget
					[ ] 
					[ ] ///Verify  $0  displayed in Graph View Summary Total Spending
					[ ] sActualSummaryTotalSpending = MDIClient.Budget.GraphViewSummaryTotalSpending.GetProperty("Caption")
					[ ] bMatch = MatchStr("*{sZero}*" , sActualSummaryTotalSpending)
					[+] if (bMatch)
						[ ] ReportStatus("Verify Summary bar status when no categories added to budget on graph view." , PASS , "Total Spending: {sActualSummaryTotalSpending} on graph view is as expected.")
					[+] else
						[ ] ReportStatus("Verify Summary bar status when no categories added to budget on graph view." , FAIL , "Total Spending: {sActualSummaryTotalSpending} on graph view is NOT as expected: {sZero}.")
					[ ] 
					[ ] ///Verify  $0  displayed in Graph View Summary Total Budget
					[ ] sActualSummaryTotalBudget = MDIClient.Budget.GraphViewSummaryTotalBudget.GetProperty("Caption")
					[ ] bMatch = MatchStr("*{sZero}*"  , sActualSummaryTotalBudget)
					[+] if (bMatch)
						[ ] ReportStatus("Verify Summary bar status when no categories added to budget on graph view." , PASS , "Total Budget: {sActualSummaryTotalBudget} on graph view is as expected.")
					[+] else
						[ ] ReportStatus("Verify Summary bar status when no categories added to budget on graph view." , FAIL , "Total Budget: {sActualSummaryTotalBudget} on graph view is NOT as expected: {sZero}.")
					[ ] ///Verify Total Savings not displayed in Graph View Summary 
					[ ] 
					[+] if ( !MDIClient.Budget.GraphViewSummaryTotalSavings.Exists())
						[ ] ReportStatus("Verify Summary bar status when no categories added to budget on graph view." , PASS , "Total Savings label is not present as Income category is not added.")
					[+] else
						[ ] ReportStatus("Verify Summary bar status when no categories added to budget on graph view." , FAIL , "Total Savings label is present when Income category is not added.")
					[ ] 
					[ ] ///Verify $0 displayed in Graph View Summary Total Left
					[ ] sActualSummaryTotalLeft = MDIClient.Budget.GraphViewSummaryTotalLeft.GetProperty("Caption")
					[ ] bMatch = MatchStr("*{sZero}*" , sActualSummaryTotalLeft)
					[+] if (bMatch)
						[ ] ReportStatus("Verify Summary bar status when no categories added to budget on graph view." , PASS , "Total Left: {sActualSummaryTotalLeft} on graph view is as expected.")
					[+] else
						[ ] ReportStatus("Verify Summary bar status when no categories added to budget on graph view." , FAIL , "Total Left: {sActualSummaryTotalLeft} on graph view is NOT as expected: {sZero}.")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify budget gets added.", FAIL, "Budget: {sBudgetName} couldn't be added.")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify budget gets deleted.", FAIL, "Budget: {sBudgetName} couldn't be deleted.")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
[ ] 
[+] //##########Test 17: Hierarchical Category List in Graph View with vertical scroll bars. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test17_VerifyHierarchicalCategoryListInGraphViewWithVerticalScrollBars
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify Hierarchical Category List in Graph View with vertical scroll bars
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Hierarchical Category List in Graph View with is displayed vertical scroll bars
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  May 23  2014
		[ ] //
	[ ] // ********************************************************
[ ] 
[+] testcase Test17_VerifyHierarchicalCategoryListInGraphViewWithVerticalScrollBars() appstate none
	[+] //--------------Variable Declaration-------------
		[ ] ///Get categories from excel
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] //Get income category
		[ ] lsCategoryList = lsExcelData[4]
		[ ] sCategoryType =lsCategoryList[1]
		[ ] sCategory=lsCategoryList[2]
		[ ] ///remove Category type from the category list 
		[ ] ListDelete(lsCategoryList ,1)
		[ ] //Remove null values from the category list
		[+] for( iCounter=1; iCounter <=ListCount (lsCategoryList) ; iCounter++)
			[+] if (lsCategoryList[iCounter]==NULL)
				[ ] ListDelete (lsCategoryList ,iCounter)
				[ ] iCounter--
				[ ] 
		[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
		[+] if (iResult==PASS)
			[ ] 
			[ ] iResult=DeleteBudget()
			[+] if (iResult==PASS)
				[ ] iResult=AddBudget(sBudgetName)
				[+] if (iResult==PASS)
					[ ] ReportStatus("Verify budget gets added.", PASS, "Budget: {sBudgetName} has been added.")
					[ ] ////Select Graph view
					[ ] QuickenWindow.SetActive()
					[ ] SelectBudgetOptionOnGraphAnnualView(sGraphView ,"Rollup")
					[ ] iResult=AddCategoriesToBudget(sCategoryType , lsCategoryList)
					[+] if (iResult==PASS)
						[ ] ReportStatus("Verify categories added to the budget.", PASS , "Categories: {lsCategoryList} of type: {sCategoryType} added to the budget.") 
						[ ] bMatch=TRUE
					[+] else
						[ ] ReportStatus("Verify categories added to the budget.", FAIL , "Categories: {lsCategoryList} of type: {sCategoryType} couldn't be added to the budget.") 
						[ ] bMatch=FALSE
					[+] if (bMatch)
						[+] if (MDIClient.Budget.ListBox.VScrollBar.Exists(2))
							[ ] ReportStatus("Verify Hierarchical Category List in Graph View is displayed with vertical scroll bars.", PASS , "Vertical scroll bar displayed when many categories added to the budget.") 
						[+] else
							[ ] ReportStatus("Verify Hierarchical Category List in Graph View is displayed with vertical scroll bars.", FAIL , "Vertical scroll bar didn't display when many categories added to the budget.") 
					[+] else
						[ ] ReportStatus("Verify categories added to the budget.", FAIL , "Categories:{lsCategoryList} couldn't be added to the budget hence testcase can not proceed.") 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify budget gets added.", FAIL, "Budget: {sBudgetName} couldn't be added.")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify budget gets deleted.", FAIL, "Budget: {sBudgetName} couldn't be deleted.")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
[ ] 
[+] //##########Test 19: Display the total values for all the 3 columns in the Header row grey area. Also change the "Overall Total" string in the budget report. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test19_VerifyTheTotalValuesForAllTheThreeCoulmnsInHistoricalBudgetReport
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify the total values in historical budget report for the actual, budget and difference columns
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If the total values in historical budget report for the actual, budget and difference columns is correct
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  May 30  2014
		[ ] //
	[ ] // ********************************************************
[ ] 
[ ] 
[+] testcase Test19_VerifyTheTotalValuesForAllTheThreeCoulmnsInHistoricalBudgetReport() appstate none
	[+] //--------------Variable Declaration-------------
		[ ] BOOLEAN bLeapYear =FALSE
		[ ] REAL rTotalBudget ,rBudgetAmount ,rTotalExpense ,rNetDifference 
		[ ] INTEGER iCategoryCount
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sAccountWorksheet)
		[ ] 
		[ ] lsAddAccount=lsExcelData[1]
		[ ] sAccountName=lsAddAccount[2]
		[ ] // Fetch 1st row from sRegTransactionSheet the given sheet
		[ ] lsTxnExcelData=NULL
		[ ] lsTxnExcelData=ReadExcelTable(sBudgetExcelsheet, sRegTransactionSheet)
		[ ] ///Spending for firs
		[ ] rTotalBudget=0
		[ ] rBudgetAmount=-50
		[ ] rTotalExpense=0
		[ ] 
		[ ] ///Remove category type and parent category from the list
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] 
		[ ] lsCategoryList = lsExcelData[1]
		[ ] sCategoryType= trim(lsCategoryList[1])
		[ ] sParentCategory=trim(lsCategoryList[2])
		[ ] ListDelete (lsCategoryList ,1)
		[ ] ListDelete (lsCategoryList ,1)
		[ ] //Remove NULL from category list
		[+] for( iCounter=1; iCounter <=ListCount (lsCategoryList) ; iCounter++)
			[+] if (lsCategoryList[iCounter]==NULL)
				[ ] ListDelete (lsCategoryList ,iCounter)
				[ ] iCounter--
				[ ] 
		[ ] 
		[ ] /// The category count 
		[ ] iCategoryCount=ListCount (lsCategoryList)
		[ ] sCurrentMonth=FormatDateTime(GetDateTime(), "m") //Get current month
		[ ] iCurrentMonth =Val(sCurrentMonth)
		[ ] 
		[ ] //Calculate budget for 12 months 
		[ ] rTotalBudget=rBudgetAmount*12*iCategoryCount
		[ ] 
		[ ] //Calculate transaction months
		[ ] iTxnMonths=4
		[+] if (iCurrentMonth<4)
			[ ] iTxnMonths =iCurrentMonth
		[ ] ///Calculate the total expense
		[+] for (iCounter=1 ;  iCounter<= 3; iCounter++)
			[ ] lsTransaction=lsTxnExcelData[iCounter]
			[+] if(lsTransaction[1]==NULL)
				[ ] break
			[ ] iTxnAmount=VAL(lsTransaction[3])
			[ ] rTotalExpense =rTotalExpense + (iTxnAmount*iTxnMonths)
		[ ] //Calculate net difference
		[ ] rNetDifference =rTotalBudget - rTotalExpense
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //Delete previous budget
		[ ] 
		[ ] iResult=DeleteBudget()
		[ ] 
		[+] if (iResult==PASS)
			[ ] 
			[ ] //Add new budget
			[ ] 
			[ ] iResult=AddBudget(sBudgetName)
			[+] if (iResult==PASS)
				[ ] 
				[ ] 
				[ ] //Add average budget for each category
				[+] for( iCounter=1; iCounter <=ListCount (lsCategoryList) ; iCounter++)
					[ ] sCategory=trim(lsCategoryList[iCounter])
					[ ] AddAverageBudget(sCategory ,rBudgetAmount)
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] ////Verify Overall Total for Personal Expenses on Graph View
				[ ] QuickenWindow.SetActive()
				[ ] //Select yearly view
				[ ] MDIClient.Budget.BudgetDurationComboBox.Select("Yearly")
				[ ] MDIClient.Budget.BudgetDurationComboBox.Select("Yearly")
				[ ] sleep(2)
				[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
				[ ] iListCount =MDIClient.Budget.ListBox.GetItemCount() 
				[ ] 
				[ ] 
				[ ] ////Verify Overall Total for Personal Expenses on Graph View
				[+] for(iCount= 0; iCount <= iListCount;  iCount++)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
					[ ] bResult = MatchStr("*{Upper(sCategoryType)}*", sActual)
					[+] if (bResult)
						[ ] bMatch = MatchStr("*{trim(str(rTotalBudget,4))}*", StrTran(sActual,",",""))
						[ ] 
						[+] if (bMatch)
							[ ] ReportStatus("Verify the total budget on Graph View for :{sCategoryType} .", PASS ,"The total budget on Graph View for: {sCategoryType} on Graph View is as expected:{str(rTotalBudget,4,2)}.")
						[+] else
							[ ] ReportStatus("Verify the total budget on Graph View {sCategoryType}.", FAIL ,"The total budget actual: {sActual} on Graph View for: {sCategoryType} on Graph View is NOT as expected:{str(rTotalBudget,4,2)} due to Defect QW-3145.")
						[ ] break
				[+] if (bResult==FALSE)
					[ ] ReportStatus("Verify the total budget on Graph View for :{sCategoryType}.", FAIL ,"Category: {sCategoryType} on Graph View couldn't be found.")
				[ ] 
				[ ] ///Select Historical Budget report on Graph View
				[ ] 
				[ ] SelectBudgetReportOnGraphView(sREPORT_HISTORICAL_BUDGET)
				[ ] 
				[+] if (HistoricalBudget.Exists(2))
					[ ] HistoricalBudget.SetActive()
					[ ] HistoricalBudget.Maximize()
					[ ] iCatCount=1
					[ ] sHandle= Str(HistoricalBudget.ListBox.GetHandle())
					[ ] iListCount =HistoricalBudget.ListBox.GetItemCount() 
					[ ] 
					[ ] ///Overall Total
					[ ] sCategoryType="EXPENSES"
					[+] for(iCount= 0; iCount <= iListCount;  iCount++)
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
						[ ] bResult = MatchStr("*{sCategoryType}*", sActual)
						[+] if (bResult)
							[ ] bMatch = MatchStr("*{str(rTotalExpense,4,2)}*{str(rTotalBudget,4,2)}*{str(rNetDifference,4,2)}*", StrTran(sActual,",",""))
							[ ] 
							[+] if (bMatch)
								[ ] ReportStatus("Verify the total values in historical budget report for the actual, budget and difference columns.", PASS ,"The actual, budget and difference columns have expected values as:{str(rTotalExpense,4,2)}, {str(rTotalBudget,4,2)} and {str(rNetDifference,4,2)} on report: {sREPORT_HISTORICAL_BUDGET} for :{sCategoryType}.")
							[+] else
								[ ] ReportStatus("Verify the total values in historical budget report for the actual, budget and difference columns.", FAIL ,"The actual, budget and difference column's values: {sActual} are NOT as expected: {str(rTotalExpense,4,2)}, {str(rTotalBudget,4,2)} and {str(rNetDifference,4,2)} on report: {sREPORT_HISTORICAL_BUDGET} for :{sCategoryType} due to Defect QW-3145.")
							[ ] break
					[+] if (bResult==FALSE)
						[ ] ReportStatus("Verify the total values in historical budget report for the actual, budget and difference columns.", FAIL ,"Category: {sCategoryType} on report: {sREPORT_HISTORICAL_BUDGET} couldn't be found.")
					[ ] 
					[ ] ////Verify root category total 
					[+] for(iCount= 0; iCount <= iListCount;  iCount++)
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
						[ ] bResult = MatchStr("*{sParentCategory}*", sActual)
						[+] if (bResult)
							[ ] bMatch = MatchStr("*{str(rTotalExpense,4,2)}*{str(rTotalBudget,4,2)}*{str(rNetDifference,4,2)}*", StrTran(sActual,",",""))
							[ ] 
							[+] if (bMatch)
								[ ] ReportStatus("Verify the total values in historical budget report for the actual, budget and difference columns.", PASS ,"The actual, budget and difference columns have expected values as:{str(rTotalExpense,4,2)}, {str(rTotalBudget,4,2)} and {str(rNetDifference,4,2)} on report: {sREPORT_HISTORICAL_BUDGET}.")
							[+] else
								[ ] ReportStatus("Verify the total values in historical budget report for the actual, budget and difference columns.", FAIL ,"The actual, budget and difference column's values: {sActual} are NOT as expected: {str(rTotalExpense,4,2)}, {str(rTotalBudget,4,2)} and {str(rNetDifference,4,2)} on report: {sREPORT_HISTORICAL_BUDGET} due to Defect QW-3145.")
							[ ] break
					[+] if (bResult==FALSE)
						[ ] ReportStatus("Verify the total values in historical budget report for the actual, budget and difference columns.", FAIL ,"Parent Category: {sParentCategory} couldn't be found on report: {sREPORT_HISTORICAL_BUDGET} .")
					[ ] HistoricalBudget.SetActive()
					[ ] HistoricalBudget.Close()
					[ ] WaitForState(HistoricalBudget , False ,2)
				[+] else
					[ ] ReportStatus("Verify report: {sREPORT_HISTORICAL_BUDGET} on budget Graph View.", FAIL , " {sREPORT_HISTORICAL_BUDGET} on budget Graph View didn't appear.") 
					[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify budget gets added.", FAIL, "Budget: {sBudgetName} couldn't be added.")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify budget gets deleted.", FAIL, "Budget: {sBudgetName} couldn't be deleted.")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
[ ] 
[ ] 
[+] //##########Test 20: Add "Everything Else" row for Personal Expense Group in budget report similar to budget planner only if it is explicitly budgeted. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test20_VerifyTheEverythingElseInHistoricalBudgetReport
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify the everything else item in Historical budget report once it is budegted 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If everything else item appears in Historical budget report correctly once it is budegted 
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  May 30  2014
		[ ] //
	[ ] // ********************************************************
[ ] 
[ ] 
[+] testcase Test20_VerifyTheEverythingElseInHistoricalBudgetReport() appstate none
	[+] //--------------Variable Declaration-------------
		[ ] BOOLEAN bLeapYear =FALSE
		[ ] REAL rTotalBudget ,rBudgetAmount ,rTotalExpense ,rNetDifference
		[ ] INTEGER iCategoryCount
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sAccountWorksheet)
		[ ] 
		[ ] lsAddAccount=lsExcelData[1]
		[ ] sAccountName=lsAddAccount[2]
		[ ] // Fetch 1st row from sRegTransactionSheet the given sheet
		[ ] lsTxnExcelData=NULL
		[ ] lsTxnExcelData=ReadExcelTable(sBudgetExcelsheet, sRegTransactionSheet)
		[ ] 
		[ ] ///Spending for firs
		[ ] rTotalBudget=0
		[ ] rBudgetAmount=50
		[ ] rTotalExpense=0
		[ ] 
		[ ] /// The category count 
		[ ] 
		[ ] //Calculate budget for 12 months for Everything Else Category
		[ ] rTotalBudget=rBudgetAmount*12
		[ ] ///rTotalExpense is zero as there are no expenses
		[ ] //Calculate net difference
		[ ] rNetDifference =rTotalBudget - rTotalExpense
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //Add average budget for everything else
		[ ] iResult=AddAverageBudget(sRootEverythingElse ,rBudgetAmount)
		[+] if (iResult==PASS)
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] ///Select Historical Budget report on Graph View
			[ ] 
			[ ] SelectBudgetReportOnGraphView(sREPORT_HISTORICAL_BUDGET)
			[ ] 
			[+] if (HistoricalBudget.Exists(2))
				[ ] HistoricalBudget.SetActive()
				[ ] HistoricalBudget.Maximize()
				[ ] iCatCount=1
				[ ] sHandle= Str(HistoricalBudget.ListBox.GetHandle())
				[ ] iListCount =HistoricalBudget.ListBox.GetItemCount() 
				[+] for(iCount= 1; iCount <= iListCount;  iCount++)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount-1))
					[ ] bResult = MatchStr("*{sRootEverythingElse}*", sActual)
					[+] if (bResult)
						[ ] bMatch = MatchStr("*{str(rTotalExpense,4,2)}*{str(rTotalBudget,4,2)}*{str(rNetDifference,4,2)}*", StrTran(sActual,",",""))
						[ ] 
						[+] if (bMatch)
							[ ] ReportStatus("Verify everything else item in Historical budget report once it is budegted.", PASS ,"The actual, budget and difference columns have expected values as:{str(rTotalExpense,4,2)}, {str(rTotalBudget,4,2)} and {str(rNetDifference,4,2)} on report: {sREPORT_HISTORICAL_BUDGET} for category: {sRootEverythingElse}.")
						[+] else
							[ ] ReportStatus("Verify the total values in historical budget report for the actual, budget and difference columns.", FAIL ,"The actual, budget and difference column's values: {sActual} are NOT as expected: {str(rTotalExpense,4,2)}, {str(rTotalBudget,4,2)} and {str(rNetDifference,4,2)} on report: {sREPORT_HISTORICAL_BUDGET} for category: {sRootEverythingElse} due to Defect QW-3145.")
						[ ] break
				[+] if (bResult==FALSE)
					[ ] ReportStatus("erify the total values in historical budget report for the actual, budget and difference columns.", FAIL ,"Category: {sRootEverythingElse} on report: {sREPORT_HISTORICAL_BUDGET} couldn't be found.")
				[ ] HistoricalBudget.SetActive()
				[ ] HistoricalBudget.Close()
				[ ] WaitForState(HistoricalBudget , False ,2)
			[+] else
				[ ] ReportStatus("Verify report: {sREPORT_HISTORICAL_BUDGET} on budget Graph View.", FAIL , " {sREPORT_HISTORICAL_BUDGET} on budget Graph View didn't appear.") 
				[ ] 
		[+] else
			[ ] ReportStatus("Verify average budget added for category: {sEverythingElse}." , FAIL ,"Average budget couldn't be added for category: {sEverythingElse}.")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
[ ] 
[+] //##########Test 21: As a user, I want to be able to see for each month the budgeted amount, actual amount and balance. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test21_VerifyTheBudgetActualAndBalanceValuesOnDetailsAnnualView
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that values for each month for budgeted amount, actual amount and balance is correct on Details View
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If the values for each month for budgeted amount, actual amount and balance is correct on Details View
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  June 01  2014
		[ ] //
	[ ] // ********************************************************
[ ] 
[ ] 
[+] testcase Test21_VerifyTheBudgetActualAndBalanceValuesForEachMonthOnDetailsAnnualView() appstate none
	[+] //--------------Variable Declaration-------------
		[ ] BOOLEAN bLeapYear =FALSE
		[ ] 
		[ ] INTEGER iCategoryCount
		[ ] STRING sExpectedPattern
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sAccountWorksheet)
		[ ] 
		[ ] lsAddAccount=lsExcelData[1]
		[ ] sAccountName=lsAddAccount[2]
		[ ] // Fetch 1st row from sRegTransactionSheet the given sheet
		[ ] lsTxnExcelData=NULL
		[ ] lsTxnExcelData=ReadExcelTable(sBudgetExcelsheet, sRegTransactionSheet)
		[ ] ///Spending for firs
		[ ] rTotalBudget=0
		[ ] rBudgetAmount=50
		[ ] rTotalExpense=0
		[ ] iNoTxnMonths=0
		[ ] rAmount=0
		[ ] rBillReminderAmount=50
		[ ] sExpectedPattern=""
		[ ] rBillReminderAmount=rBudgetAmount
		[ ] 
		[ ] /// The category count 
		[ ] sCurrentMonth=FormatDateTime(GetDateTime(), "m") //Get current month
		[ ] iCurrentMonth =Val(sCurrentMonth)
		[ ] ///Remove category type and parent category from the list
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] 
		[ ] lsCategoryList = lsExcelData[1]
		[ ] sCategoryType= trim(lsCategoryList[1])
		[ ] sParentCategory=trim(lsCategoryList[2])
		[ ] ListDelete (lsCategoryList ,1)
		[ ] ListDelete (lsCategoryList ,1)
		[ ] //Remove NULL from category list
		[+] for( iCounter=1; iCounter <=ListCount (lsCategoryList) ; iCounter++)
			[+] if (lsCategoryList[iCounter]==NULL)
				[ ] ListDelete (lsCategoryList ,iCounter)
				[ ] iCounter--
				[ ] 
		[ ] 
		[ ] 
		[ ] //Calculate transaction months
		[ ] iTxnMonths=4
		[+] if (iCurrentMonth<=4)
			[ ] iNoTxnMonths=0
			[ ] 
		[+] else
			[ ] iNoTxnMonths=iCurrentMonth-4
		[ ] 
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //Delete previous budget
		[ ] 
		[ ] iResult=DeleteBudget()
		[ ] 
		[+] if (iResult==PASS)
			[ ] 
			[ ] //Add new budget
			[ ] 
			[ ] iResult=AddBudget(sBudgetName)
			[+] if (iResult==PASS)
				[ ] 
				[ ] //Add average budget for each category
				[ ] 
				[+] for( iCounter=1; iCounter <=ListCount (lsCategoryList) ; iCounter++)
					[ ] sCategory=trim(lsCategoryList[iCounter])
					[ ] AddAverageBudget(sCategory ,rBudgetAmount)
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] ////Verify budgeted amount, actual amount and balance on details view
				[ ] QuickenWindow.SetActive()
				[ ] //Select yearly view
				[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sAnnualView)
				[ ] sleep(2)
				[ ] ///select details view on annual view
				[ ] MDIClient.Budget.AnnualViewTypeComboBox.Select("Details")
				[ ] sleep(2)
				[ ] MDIClient.Budget.ShowBalanceInFutureMonthsCheckBox.Check()
				[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
				[ ] iListCount =MDIClient.Budget.ListBox.GetItemCount() 
				[ ] 
				[ ] ///Calculate the budgeted amount, actual amount and balance on details view
				[+] for (iCount=1 ;  iCount<= 3; iCount++)
					[ ] lsTransaction=lsTxnExcelData[iCount]
					[+] if(lsTransaction[1]==NULL)
						[ ] break
						[ ] 
					[ ] sCategory=trim(lsTransaction[8])
					[ ] sExpectedPattern=""
					[+] for (iCounter=1 ;  iCounter<= iCurrentMonth; iCounter++)
						[+] if(iNoTxnMonths>0)
							[+] if (iCounter<=iNoTxnMonths)
								[ ] rTxnAmount=0
							[+] else
								[ ] rTxnAmount=VAL(lsTransaction[3])
						[+] else
							[ ] rTxnAmount=VAL(lsTransaction[3])
						[ ] ///This is to add reminder amount in the first transaction
						[+] if (iCounter==iCurrentMonth)
							[+] if (iCount==1)
								[ ] rAmount=rTxnAmount+rBillReminderAmount
						[+] else
							[ ] rAmount=rTxnAmount
						[ ] rBalance=rBudgetAmount-rAmount
						[ ] sExpectedPattern=sExpectedPattern+"@{trim(str(rBudgetAmount,4))}@{trim(str(rAmount,4))}@{trim(str(rBalance,4))}"
					[ ] ///Verify budgeted amount, actual amount and balance on details view
					[+] for(iCounter= 1; iCounter <= iListCount;  iCounter++)
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCounter))
						[ ] 
						[+] // Manipulate sActual to remove extraneous characters otherwise pattern won't match
							[ ] sActual=StrTran( sActual, "<af href=Actual>","")
							[ ] 
							[ ] sActual=StrTran( sActual, "</a>","")
							[ ] sActual=StrTran( sActual, "@@","@")
							[ ] sActual=StrTran( sActual, "<font style=","")
							[ ] sActual=StrTran( sActual, "color:#ff0000","")
							[ ] sActual=StrTran( sActual, "</font>","")
							[ ] sActual=StrTran( sActual, ">","")
							[ ] 
							[ ] sActual=StrTran( sActual,chr(34),"")
						[ ] 
						[ ] 
						[ ] bMatch = MatchStr("*{sExpectedPattern}*",sActual)
						[+] if (bMatch)
							[ ] break
					[+] if (bMatch)
						[ ] ReportStatus("Verify that values for each month for budgeted amount, actual amount and balance is correct on Details View .", PASS ,"The values for each month for budgeted amount, actual amount and balance is as expected:{sExpectedPattern} on Details View for {sCategory}.")
					[+] else
						[ ] ReportStatus("Verify that values for each month for budgeted amount, actual amount and balance is correct on Details View .", FAIL ,"The values for each month for budgeted amount, actual amount and balance is NOT as expected:{sExpectedPattern} on Details View for {sCategory}.")
						[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify budget gets added.", FAIL, "Budget: {sBudgetName} couldn't be added.")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify budget gets deleted.", FAIL, "Budget: {sBudgetName} couldn't be deleted.")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
[ ] 
[+] //##########Test 23: Summary Bar for negative budget values. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test23_VerifySummaryBarForNegativeBudgetVaues
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify Summary Bar for negative budget values.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If verification is correct for Summary Bar for negative budget values.
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  June 03  2014
		[ ] //
	[ ] // ********************************************************
[ ] 
[+] testcase Test23_VerifySummaryBarForNegativeBudgetVaues() appstate none
	[+] //--------------Variable Declaration-------------
		[ ] 
		[ ] 
		[ ] bMatch=FALSE
		[ ] 
		[ ] 
		[ ] // Fetch 1st row from sRegTransactionSheet the given sheet
		[ ] lsTxnExcelData=NULL
		[ ] lsTxnExcelData=ReadExcelTable(sBudgetExcelsheet, sRegTransactionSheet)
		[ ] 
		[ ] 
		[ ] iBudgetAmount=50
		[ ] iBillReminderAmount=50
		[ ] iTotalExpense=0
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] 
		[ ] ///Remove category type and parent category from the list
		[ ] lsCategoryList = lsExcelData[1]
		[ ] sCategoryType =lsCategoryList[1]
		[ ] ListDelete (lsCategoryList ,1)
		[ ] ListDelete (lsCategoryList ,1)
		[ ] //Remove NULL from category list
		[ ] 
		[+] for( iCounter=1; iCounter <=ListCount (lsCategoryList) ; iCounter++)
			[+] if (lsCategoryList[iCounter]==NULL)
				[ ] ListDelete (lsCategoryList ,iCounter)
				[ ] iCounter--
				[ ] 
		[ ] iListCount=ListCount (lsCategoryList)
		[ ] ///Get the first sub-category
		[ ] sCategory=trim(lsCategoryList[1])
		[ ] ////Calculate total budget for three categories
		[ ] 
		[ ] iTotalBudget=iBudgetAmount*(iListCount-1)
		[ ] ///Substract negative budget for  first sub-category
		[ ] iTotalBudget=iTotalBudget-iBudgetAmount
		[ ] //Total expense
		[+] for (iCount=1 ;  iCount<= 3; iCount++)
			[ ] lsTransaction=lsTxnExcelData[iCount]
			[+] if(lsTransaction[1]==NULL)
				[ ] break
				[ ] 
			[ ] iTxnAmount=VAL(lsTransaction[3])
			[ ] iTotalExpense=iTotalExpense +iTxnAmount
		[ ] //Add reminder amount to total expense
		[ ] iTotalExpense=iTotalExpense+iBillReminderAmount
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] ////Verify summary bar on Graph View
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sGraphView)
		[ ] sleep(4)
		[ ] MDIClient.Budget.BudgetDurationComboBox.Select("Monthly")
		[ ] 
		[ ] sleep(2)
		[ ] ///Add negative budget for first sub-category
		[ ] iBudgetAmount=-50
		[ ] iResult=AddAverageBudget(sCategory ,iBudgetAmount)
		[+] if (iResult==PASS)
			[ ] ReportStatus("Verify negative budget added to the category", PASS ,"The negative budget: {iBudgetAmount} added to the category: {sCategory}.")
			[ ] ///Verify Graph View Summary> Total Spending
			[ ] iTotalSpending=iTotalExpense
			[ ] sActualSummaryTotalSpending = MDIClient.Budget.GraphViewSummaryTotalSpending.GetProperty("Caption")
			[ ] bMatch = MatchStr("*{str(iTotalSpending)}*" ,StrTran( sActualSummaryTotalSpending,"$",""))
			[+] if (bMatch)
				[ ] ReportStatus("Verify Summary Bar for negative budget values on Graph View." , PASS , "Summary bar spending: {sActualSummaryTotalSpending} is as expected: {iTotalSpending} on Graph View.")
			[+] else
				[ ] ReportStatus("Verify Summary Bar for negative budget values on Graph View." , FAIL , "Summary bar spending: {sActualSummaryTotalSpending} is NOT as expected: {iTotalSpending} on Graph View due to Defect QW-3145.")
			[ ] 
			[ ] 
			[ ] ///Verify Graph View Summary> Total Budget
			[ ] sActualSummaryTotalBudget = MDIClient.Budget.GraphViewSummaryTotalBudget.GetProperty("Caption")
			[ ] bMatch = MatchStr("*{str(iTotalBudget)}*" ,StrTran( sActualSummaryTotalBudget,"$",""))
			[+] if (bMatch)
				[ ] ReportStatus("Verify Summary Bar for negative budget values on Graph View." , PASS , "Summary bar budget: {sActualSummaryTotalBudget} is as expected: {iTotalBudget} on Graph View.")
			[+] else
				[ ] ReportStatus("Verify Summary Bar for negative budget values on Graph View." , FAIL , "Summary bar budget: {sActualSummaryTotalBudget} is NOT as expected: {iTotalBudget} on Graph View Defect QW-3145.")
			[ ] 
			[ ] ///Verify Graph View Summary> Left over
			[ ] iLeftover = iTotalBudget-iTotalSpending
			[ ] sActualGraphViewSummaryTotalLeft = MDIClient.Budget.GraphViewSummaryTotalLeft.GetProperty("Caption")
			[ ] bMatch = MatchStr("*{str(-iLeftover)}*" ,StrTran( sActualGraphViewSummaryTotalLeft,"$",""))
			[+] if (bMatch)
				[ ] ReportStatus("Verify Summary Bar for negative budget values on Graph View." , PASS , "Summary bar leftover: {sActualGraphViewSummaryTotalLeft} is as expected: {iLeftover} on Graph View.")
			[+] else
				[ ] ReportStatus("Verify Summary Bar for negative budget values on Graph View." , FAIL , "Summary bar leftover: {sActualGraphViewSummaryTotalLeft} is NOT as expected: {iLeftover} on Graph View Defect QW-3145.")
		[+] else
			[ ] ReportStatus("Verify negative budget added to the category", FAIL ,"The negative budget: {iBudgetAmount} couldn't be added to the category: {sCategory}.")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
[ ] 
[+] //##########Test 28: As a user, when adding/deleting a category it should be done on a year by year basis. ###############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test28_VerifyThatCategoryGetsDeletedFromAllMonthsOfCurrentFiscalYear
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that once a category is deleted it should be removed for all months of the current fiscal year
		[ ] //
		[ ] //
		[ ] // RETURNS:			Pass 		If category is deleted it should be removed for all months of the current fiscal year
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  June 04 2014
		[ ] //
	[ ] // ********************************************************
[ ] 
[+] testcase Test28_VerifyThatCategoryGetsDeletedFromAllMonthsOfCurrentFiscalYear() appstate none
	[ ] 
	[ ] //--------------Variable Declaration-------------
	[+] 
		[ ] STRING sMonth,sCurrentMonth,sCurrentYear,sActualMonth,sExpectedMonth,sExpectedCurrentMonth,sExpectedAmount,sActualAmount
		[ ] INTEGER  iMonth ,iMonthDifference, iBackTraversal ,iForwardTraversal
		[ ] bMatch=FALSE
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] lsCategoryList = lsExcelData[1]
		[ ] sCategoryType =lsCategoryList[1]
		[ ] sCategory=lsCategoryList[3]
		[ ] iBudgetAmount=50
		[ ] sAmount="0 left"
		[ ] iForwardTraversal=11
		[ ] sCurrentMonth=FormatDateTime(GetDateTime(), "mmmm") //Get current month as January 2014
		[ ] sCurrentYear=FormatDateTime(GetDateTime(),"yyyy")
		[ ] sExpectedCurrentMonth=sCurrentMonth+" "+sCurrentYear
		[ ] 
		[ ] 
		[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
		[+] if (iResult==PASS)
			[ ] sleep(2)
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] ////Select Graph View of budget
			[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sGraphView)
			[ ] sleep(2)
			[ ] SelectBudgetOptionOnGraphAnnualView(sGraphView,"Rollup")
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] ////Remove the Auto & Transport: Auto Insurance from the budget
			[ ] RemoveCategoryFromBudget(sCategory)
			[ ] ///Verify that once a category is deleted it should be removed for all months of the current fiscal year on Graph View
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] sActualMonth=MDIClient.Budget.CurrentMonthStaticText.GetText()
			[+] while (sActualMonth!=lsListOfMonths[1]+" "+sCurrentYear)
				[ ] MDIClient.Budget.BackWardMonthButton.Click()
				[ ] sActualMonth=MDIClient.Budget.CurrentMonthStaticText.GetText()
				[ ] 
			[+] for (iCounter=1 ; iCounter<=11;++iCounter)
				[ ] sActualMonth=MDIClient.Budget.CurrentMonthStaticText.GetText()
				[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
				[ ] iListCount= MDIClient.Budget.ListBox.GetItemCount() +1
				[ ] 
				[ ] ///Starting count with first subcategory as we know which category we are editing 
				[ ] 
				[+] for (iCount=1; iCount<=iListCount;++iCount)
					[ ] 
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
					[ ] bMatch = MatchStr("*{sCategory}*", sActual)
					[+] if (bMatch)
						[ ] break
				[+] if(bMatch==FALSE)
					[ ] ReportStatus("Verify that once a category is deleted it should be removed for all months of the current fiscal year" ,PASS, "The category: {sCategory} is deleted for the month:{sActualMonth} on Graph view.")
				[+] else
					[ ] ReportStatus("Verify that once a category is deleted it should be removed for all months of the current fiscal year" ,FAIL, "The category: {sCategory}  couldn't be deleted for the month:{sActualMonth} category: {sCategory} on Graph view.")
				[ ] //Move to the next month
				[ ] MDIClient.Budget.ForwardMonthButton.Click()
			[ ] 
			[ ] ///Verify that once a category is deleted it should be removed for all months of the current fiscal year on Annual View
			[ ] ////Select Annual View of the budget
			[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sAnnualView)
			[ ] 
			[+] do
				[ ] MDIClient.Budget.TextClick(sCategory)
				[ ] ReportStatus("Verify that once a category is deleted it should be removed for all months of the current fiscal year" ,FAIL, "The category: {sCategory}  couldn't be deleted for the month:{sActualMonth} category: {sCategory} on Annual view.")
			[+] except
				[ ] ReportStatus("Verify that once a category is deleted it should be removed for all months of the current fiscal year" ,PASS, "The category: {sCategory} is deleted for the month:{sActualMonth} on Annual view.")
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.")  
	[ ] 
[ ] 
[ ] 
[+] //##########Test 32: Verify budget amount for Everything Else for individual categories are added up to parent category budget amount on budget reports. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test32_VerifyThatBudgetAmountForEverythingElseAddsToParentInBudgetReports
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify budget amount for Everything Else for individual categories are added up to parent category budget amount on budget reports
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If budget amount for Everything Else for individual categories are added up to parent category budget amount on budget reports
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  June 11 2014
		[ ] //
	[ ] // ********************************************************
[ ] 
[+] testcase Test32_VerifyThatBudgetAmountForEverythingElseAddsToParentInBudgetReports() appstate none
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] STRING sParentCategoryAmount ,sEverythingElseAmount
		[ ] bMatch=FALSE
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] 
		[ ] ///Remove category type and parent category from the list
		[ ] lsCategoryList = lsExcelData[1]
		[ ] sCategoryType =trim(lsCategoryList[1])
		[ ] sParentCategory =trim(lsCategoryList[2])
		[ ] ListDelete (lsCategoryList ,1)
		[ ] sCategory= trim(lsCategoryList[2])
		[ ] 
		[ ] //Remove NULL from category list
		[ ] 
		[+] for( iCounter=1; iCounter <=ListCount (lsCategoryList) ; iCounter++)
			[+] if (lsCategoryList[iCounter]==NULL)
				[ ] ListDelete (lsCategoryList ,iCounter)
				[ ] iCounter--
				[ ] 
		[ ] 
		[ ] iBudgetAmount=50
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //Delete previous budget
		[ ] 
		[ ] iResult=DeleteBudget()
		[ ] 
		[+] if (iResult==PASS)
			[ ] 
			[ ] //Add new budget
			[ ] 
			[ ] iResult=AddBudget(sBudgetName)
			[+] if (iResult==PASS)
				[ ] ///Add parent category to budegt to enable category level everything else
				[ ] iResult=SelectOneCategoryToBudget(sCategoryType , sParentCategory)
				[ ] 
				[+] if(iResult==PASS)
					[ ] QuickenWindow.SetActive()
					[ ] ////Remove sParentCategory from category list
					[ ] ListDelete(lsCategoryList, 1)
					[ ] ////Append sEverythingElse to category list
					[ ] 
					[ ] ListAppend(lsCategoryList , sEverythingElse)
					[ ] 
					[ ] ///Add budget for the categories
					[ ] sCategory=NULL
					[ ] iListCount=ListCount (lsCategoryList)
					[+] for each sCategory in lsCategoryList
						[ ] AddAverageBudget(sCategory ,iBudgetAmount)
					[ ] 
					[ ] ///Verify budget for everything else in historical budget report
					[ ] iTotalBudget=iBudgetAmount*iListCount*12
					[ ] 
					[ ] SelectBudgetReportOnGraphView(sREPORT_HISTORICAL_BUDGET)
					[+] if (HistoricalBudget.Exists(5))
						[ ] HistoricalBudget.SetActive()
						[ ] HistoricalBudget.Maximize()
						[ ] iCatCount=1
						[ ] sHandle= Str(HistoricalBudget.ListBox.GetHandle())
						[ ] iListCount =HistoricalBudget.ListBox.GetItemCount() 
						[+] for(iCount= 1; iCount <= iListCount;  iCount++)
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
							[ ] bResult = MatchStr("*{sParentCategory}*", sActual)
							[+] if (bResult)
								[ ] bMatch = MatchStr("*{sParentCategory}*{iTotalBudget}*", StrTran(sActual,",",""))
								[+] if (bMatch)
									[ ] ReportStatus("Verify that budget of everything else is added to Parent category in the report.", PASS ,"Budget of category: {sEverythingElse} is added to Parent Category: {sParentCategory} on report: {sREPORT_HISTORICAL_BUDGET} as expected: {iTotalBudget}.")
								[+] else
									[ ] ReportStatus("Verify that budget of everything else is added to Parent category in the report.", FAIL ,"Budget of category: {sEverythingElse} is NOT added to Parent Category: {sParentCategory} on report: {sREPORT_HISTORICAL_BUDGET} as actual is: {sActual} against expected: {iTotalBudget}..")
								[ ] 
								[ ] break
							[ ] 
						[+] if (bResult==FALSE)
							[ ] ReportStatus("Verify that budget of everything else is added to Parent category in the report.", FAIL ,"Parent Category: {sParentCategory} couldn't be found on report: {sREPORT_HISTORICAL_BUDGET} .")
							[ ] 
						[ ] HistoricalBudget.SetActive()
						[ ] HistoricalBudget.Close()
						[ ] WaitForState(HistoricalBudget , False ,2)
					[+] else
						[ ] ReportStatus("Verify report: {sREPORT_CURRENT_BUDGET} on budget Graph View.", FAIL , " {sREPORT_CURRENT_BUDGET} on budget Graph View didn't appear.") 
						[ ] 
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify category added to the budget.", FAIL , "Category: {sParentCategory} of type: {sCategoryType} couldn't be added to the budget.") 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify budget gets added.", FAIL, "Budget: {sBudgetName} couldn't be added.")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify budget gets deleted.", FAIL, "Budget: {sBudgetName} couldn't be deleted.")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
	[ ] 
[ ] 
[ ] 
[+] //##########Test 40: As a user, when I add a total category in annual view, I want it to automatically contain the sum of all current sub-categories with both positive and negative values. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test40_VerifyThatTotalCategoryContainsSumOfSubCategoriesWithPositiveAndNegativeBudgets
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify the category total is sum of sub categories with positive and negative budgets
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If category total is sum of sub categories with positive and negative budgets
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  June 17  2014
		[ ] //
	[ ] // ********************************************************
[ ] 
[+] testcase Test40_VerifyThatTotalCategoryContainsSumOfSubCategoriesWithPositiveAndNegativeBudgets() appstate none
	[+] //--------------Variable Declaration-------------
		[ ] 
		[ ] LIST OF ANYTYPE lsCategoryBudget
		[ ] ///Remove category type and parent category from the list
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] lsCategoryList=NULL
		[ ] lsCategoryList = lsExcelData[1]
		[ ] sCategoryType=trim(lsCategoryList[1])
		[ ] sParentCategory=trim(lsCategoryList[2])
		[ ] lsCategoryList=NULL
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sBudgetedCategoriesWorksheet)
		[ ] 
		[ ] lsCategoryList = lsExcelData[1]
		[ ] lsCategoryBudget= lsExcelData[3]
		[ ] iTotalBudget=0
		[ ] ///Remove NULL from the lists
		[ ] sCurrentMonth=FormatDateTime(GetDateTime(), "m") 
		[+] for( iCounter=1; iCounter <=ListCount (lsCategoryList) ; iCounter++)
			[+] if (lsCategoryList[iCounter]==NULL)
				[ ] ListDelete (lsCategoryList ,iCounter)
				[ ] iCounter--
				[ ] 
		[ ] 
		[+] for( iCounter=1; iCounter <=ListCount (lsCategoryBudget) ; iCounter++)
			[+] if (lsCategoryBudget[iCounter]==NULL)
				[ ] ListDelete (lsCategoryBudget ,iCounter)
				[ ] iCounter--
				[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
		[+] if (iResult==PASS)
			[ ] iResult=DeleteBudget()
			[+] if (iResult==PASS)
				[ ] iResult=AddBudget(sBudgetName)
				[+] if (iResult==PASS)
					[ ] ReportStatus("Verify budget gets added.", PASS, "Budget: {sBudgetName} has been added.")
					[ ] QuickenWindow.SetActive()
					[ ] 
					[ ] //Set RollupOn on Graph View
					[ ] SelectBudgetOptionOnGraphAnnualView(sGraphView,"Rollup")
					[ ] 
					[ ] 
					[ ] 
					[+] for( iCounter=1; iCounter <=ListCount (lsCategoryList) ; iCounter++)
						[ ] iBudgetAmount=VAL(lsCategoryBudget[iCounter])
						[ ] sCategory=trim(lsCategoryList[iCounter])
						[ ] MDIClient.Budget.ListBox.TextClick(sCategory)
						[ ] MDIClient.Budget.ListBox.Amount.SetText(str(iBudgetAmount))
						[ ] sleep(0.5)
						[ ] MDIClient.Budget.ListBox.Amount.TypeKeys(KEY_ENTER)
						[ ] sleep(1)
						[ ] iTotalBudget=iTotalBudget+iBudgetAmount
						[ ] 
					[ ] 
					[ ] 
					[ ] QuickenWindow.SetActive()
					[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
					[ ] iListCount= MDIClient.Budget.ListBox.GetItemCount() +1
					[+] for(iCount= 0; iCount <= iListCount;  iCount++)
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
						[ ] bMatch = MatchStr("*{sParentCategory}*{iTotalBudget}*", sActual)
						[+] if(bMatch)
							[ ] break
					[ ] 
					[+] if (bMatch)
						[ ] ReportStatus("Verify the category total is sum of sub categories with positive and negative budgets." , PASS , "Total of the parent category is:{iTotalBudget} sum of all sub-categories: {lsCategoryList} with positive and negative budegts respectively:{lsCategoryBudget} on graph view.")
					[+] else
						[ ] ReportStatus("Verify the category total is sum of sub categories with positive and negative budgets." , FAIL , "Total of the parent category actual: {sActual} is NOT as expected: {iTotalBudget} sum of all sub-categories: {lsCategoryList} with positive and negative budegts respectively:{lsCategoryBudget} on graph view.")
					[ ] 
					[ ] 
					[ ] ///Verfiy budget total on annual view
					[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sAnnualView)
					[ ] QuickenWindow.SetActive()
					[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
					[ ] iListCount= MDIClient.Budget.ListBox.GetItemCount() +1
					[+] for(iCount= 0; iCount <= iListCount;  iCount++)
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
						[ ] bMatch = MatchStr("*{iTotalBudget}*", sActual)
						[+] if(bMatch)
							[ ] break
					[ ] 
					[+] if (bMatch)
						[ ] ReportStatus("Verify the category total is sum of sub categories with positive and negative budgets." , PASS , "Total of the parent category is:{iTotalBudget} sum of all sub-categories: {lsCategoryList} with positive and negative budegts respectively:{lsCategoryBudget} on Annual view.")
					[+] else
						[ ] ReportStatus("Verify the category total is sum of sub categories with positive and negative budgets." , FAIL , "Total of the parent category actual: {sActual} is NOT as expected: {iTotalBudget} sum of all sub-categories: {lsCategoryList} with positive and negative budegts respectively:{lsCategoryBudget} on Annual view.")
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify budget gets added.", FAIL, "Budget: {sBudgetName} couldn't be added.")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify budget gets deleted.", FAIL, "Budget: {sBudgetName} couldn't be deleted.")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
[ ] 
[+] //##########Test 42: Verify budget amount of category group total.. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test42_VerifyCategoryGroupTotalThatContainsSumOfSubCategoriesWithPositiveAndNegativeBudgets
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify the category group total is sum of sub categories with positive and negative budgets
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If category group total is sum of sub categories with positive and negative budgets
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  June 17  2014
		[ ] //
	[ ] // ********************************************************
[ ] 
[+] testcase Test42_VerifyCategoryGroupTotalThatContainsSumOfSubCategoriesWithPositiveAndNegativeBudgets() appstate none
	[+] //--------------Variable Declaration-------------
		[ ] 
		[ ] ///Remove category type and parent category from the list
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] 
		[ ] lsCategoryList = lsExcelData[1]
		[ ] sCategoryType=trim(lsCategoryList[1])
		[ ] sParentCategory=trim(lsCategoryList[2])
		[ ] lsCategoryList=NULL
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sBudgetedCategoriesWorksheet)
		[ ] 
		[ ] lsCategoryList = lsExcelData[1]
		[ ] lsCategoryBudget= lsExcelData[3]
		[ ] iTotalBudget=0
		[ ] ///Remove NULL from the lists
		[ ] sCurrentMonth=FormatDateTime(GetDateTime(), "m") 
		[+] for( iCounter=1; iCounter <=ListCount (lsCategoryList) ; iCounter++)
			[+] if (lsCategoryList[iCounter]==NULL)
				[ ] ListDelete (lsCategoryList ,iCounter)
				[ ] iCounter--
				[ ] 
		[ ] 
		[+] for( iCounter=1; iCounter <=ListCount (lsCategoryBudget) ; iCounter++)
			[+] if (lsCategoryBudget[iCounter]==NULL)
				[ ] ListDelete (lsCategoryBudget ,iCounter)
				[ ] iCounter--
				[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
		[+] if (iResult==PASS)
			[ ] iResult=DeleteBudget()
			[+] if (iResult==PASS)
				[ ] iResult=AddBudget(sBudgetName)
				[+] if (iResult==PASS)
					[ ] ReportStatus("Verify budget gets added.", PASS, "Budget: {sBudgetName} has been added.")
					[ ] QuickenWindow.SetActive()
					[ ] 
					[ ] //Set RollupOn on Graph View
					[ ] SelectBudgetOptionOnGraphAnnualView(sGraphView,"Rollup")
					[+] for( iListCounter=2; iListCounter <=ListCount (lsExcelData) ; iListCounter++)
						[ ] lsCategoryBudget=lsExcelData[iListCounter]
						[ ] iTotalBudget=0
						[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sGraphView)
						[ ] sleep(2)
						[+] if (iListCounter==ListCount (lsExcelData))
							[ ] //Add parent category to enable the Everything Else
							[ ] SelectOneCategoryToBudget(sCategoryType , sParentCategory)
							[ ] sleep(2)
							[ ] ListAppend(lsCategoryList,sEverythingElse)
							[ ] ListAppend(lsCategoryBudget,"50")
							[ ] 
						[ ] 
						[+] for( iCounter=1; iCounter <=ListCount (lsCategoryList) ; iCounter++)
							[ ] iBudgetAmount=VAL(lsCategoryBudget[iCounter])
							[ ] sCategory=trim(lsCategoryList[iCounter])
							[ ] MDIClient.Budget.ListBox.TextClick(sCategory)
							[ ] MDIClient.Budget.ListBox.Amount.SetText(str(iBudgetAmount))
							[ ] sleep(0.5)
							[ ] MDIClient.Budget.ListBox.Amount.TypeKeys(KEY_ENTER)
							[ ] sleep(1)
							[ ] iTotalBudget=iTotalBudget+iBudgetAmount
							[ ] 
						[ ] 
						[ ] 
						[ ] QuickenWindow.SetActive()
						[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
						[ ] iListCount= MDIClient.Budget.ListBox.GetItemCount() +1
						[+] for(iCount= 0; iCount <= iListCount;  iCount++)
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
							[ ] bResult = MatchStr("*{sCategoryType}*{iTotalBudget}*", sActual)
							[+] if(bResult)
								[ ] iCounter=iCount+1
								[+] for(iCount= iCounter; iCount <= iListCount;  iCount++)
									[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
									[ ] bMatch = MatchStr("*{sParentCategory}*{iTotalBudget}*", sActual)
									[+] if(bMatch)
										[ ] break
								[+] if (bMatch)
									[ ] ReportStatus("Verify the category total is sum of sub categories with positive and negative budgets." , PASS , "Total of the parent category: {sParentCategory} is:{iTotalBudget} sum of all sub-categories: {lsCategoryList} with positive and negative budegts respectively:{lsCategoryBudget} on graph view.")
								[+] else
									[ ] ReportStatus("Verify the category total is sum of sub categories with positive and negative budgets." , FAIL , "Total of the parent category: {sParentCategory} actual: {sActual} is NOT as expected: {iTotalBudget} sum of all sub-categories: {lsCategoryList} with positive and negative budegts respectively:{lsCategoryBudget} on graph view.")
								[ ] 
								[ ] break
						[ ] 
						[+] if (bResult)
							[ ] ReportStatus("Verify the category group total is sum of sub categories with positive and negative budgets." , PASS , "Total of the category group: {sCategoryType} is:{iTotalBudget} sum of all sub-categories: {lsCategoryList} with positive and negative budegts respectively:{lsCategoryBudget} on graph view.")
						[+] else
							[ ] ReportStatus("Verify the category group total is sum of sub categories with positive and negative budgets." , FAIL , "Total of the category group: {sCategoryType} actual: {sActual} is NOT as expected: {iTotalBudget} sum of all sub-categories: {lsCategoryList} with positive and negative budegts respectively:{lsCategoryBudget} on graph view.")
						[ ] 
						[ ] 
						[ ] ///Verfiy budget total on annual view
						[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sAnnualView)
						[ ] QuickenWindow.SetActive()
						[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
						[ ] iListCount= MDIClient.Budget.ListBox.GetItemCount() +1
						[+] for(iCount= 0; iCount <= iListCount;  iCount++)
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
							[ ] bResult = MatchStr("*{iTotalBudget}*", sActual)
							[+] if(bResult)
								[ ] iCounter=iCount+1
								[+] for(iCount= iCounter; iCount <= iListCount;  iCount++)
									[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
									[ ] bMatch = MatchStr("*{iTotalBudget}*", sActual)
									[+] if(bMatch)
										[ ] break
								[+] if (bMatch)
									[ ] ReportStatus("Verify the category total is sum of sub categories with positive and negative budgets." , PASS , "Total of the parent category: {sParentCategory} is:{iTotalBudget} sum of all sub-categories: {lsCategoryList} with positive and negative budegts respectively:{lsCategoryBudget} on annual view.")
								[+] else
									[ ] ReportStatus("Verify the category total is sum of sub categories with positive and negative budgets." , FAIL , "Total of the parent category: {sParentCategory} actual: {sActual} is NOT as expected: {iTotalBudget} sum of all sub-categories: {lsCategoryList} with positive and negative budegts respectively:{lsCategoryBudget} on annual view.")
								[ ] 
								[ ] break
						[+] if (bResult)
							[ ] ReportStatus("Verify the category group total is sum of sub categories with positive and negative budgets." , PASS , "Total of the category group: {sCategoryType} is:{iTotalBudget} sum of all sub-categories: {lsCategoryList} with positive and negative budegts respectively:{lsCategoryBudget} on annual view.")
						[+] else
							[ ] ReportStatus("Verify the category group total is sum of sub categories with positive and negative budgets." , FAIL , "Total of the category group: {sCategoryType} actual: {sActual} is NOT as expected: {iTotalBudget} sum of all sub-categories: {lsCategoryList} with positive and negative budegts respectively:{lsCategoryBudget} on annual view.")
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify budget gets added.", FAIL, "Budget: {sBudgetName} couldn't be added.")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify budget gets deleted.", FAIL, "Budget: {sBudgetName} couldn't be deleted.")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
[ ] 
[+] //##########Test 46: As a user, I want to able to create a new years budget (12 more months) within the existing budget. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test46_VerifyCreationOfPreviousAndNextYearsBudgetWithExistingBudget
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that the creation of previous and next year's budget using current year budget
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If the creation of previous and next year's budget using current year budget is correct
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  June 24  2014
		[ ] //
	[ ] // ********************************************************
[ ] 
[+] testcase Test46_VerifyCreationOfPreviousAndNextYearsBudgetWithExistingBudget() appstate none
	[+] //--------------Variable Declaration-------------
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] 
		[ ] lsCategoryList = lsExcelData[1]
		[ ] sCategoryType=trim(lsCategoryList[1])
		[ ] sParentCategory=trim(lsCategoryList[2])
		[ ] 
		[ ] lsCategoryList=NULL
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sBudgetedCategoriesWorksheet)
		[ ] 
		[ ] lsCategoryList = lsExcelData[1]
		[ ] lsCategoryBudget= lsExcelData[3]
		[ ] iTotalBudget=0
		[ ] ///Remove NULL from the lists
		[ ] sCurrentMonth=FormatDateTime(GetDateTime(), "m") 
		[+] for( iCounter=1; iCounter <=ListCount (lsCategoryList) ; iCounter++)
			[+] if (lsCategoryList[iCounter]==NULL)
				[ ] ListDelete (lsCategoryList ,iCounter)
				[ ] iCounter--
				[ ] 
		[ ] 
		[+] for( iCounter=1; iCounter <=ListCount (lsCategoryBudget) ; iCounter++)
			[+] if (lsCategoryBudget[iCounter]==NULL)
				[ ] ListDelete (lsCategoryBudget ,iCounter)
				[ ] iCounter--
				[ ] 
		[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iResult=DeleteBudget()
		[+] if (iResult==PASS)
			[ ] iResult=AddBudget(sBudgetName)
			[+] if (iResult==PASS)
				[ ] ReportStatus("Verify budget gets added.", PASS, "Budget: {sBudgetName} has been added.")
				[ ] 
				[ ] ///Add average budget for all categories
				[+] for( iCounter=1; iCounter <=ListCount (lsCategoryList) ; iCounter++)
					[ ] iBudgetAmount=VAL(lsCategoryBudget[iCounter])
					[ ] sCategory=trim(lsCategoryList[iCounter])
					[ ] AddAverageBudget(sCategory , iBudgetAmount)
					[ ] 
				[ ] 
				[ ] QuickenWindow.SetActive()
				[ ] sleep(2)
				[ ] ////Create budget for previous year
				[ ] 
				[+] while (!DlgAddABudgetForNextOrPreviousYear.Exists())
					[ ] MDIClient.Budget.BackWardMonthButton.Click()
					[ ] ///Extend budget for next year using second option
				[+] if (DlgAddABudgetForNextOrPreviousYear.Exists(5))
					[ ] DlgAddABudgetForNextOrPreviousYear.SetActive()
					[ ] sActual =DlgAddABudgetForNextOrPreviousYear.GetProperty("Caption")
					[ ] DlgAddABudgetForNextOrPreviousYear.RadioListCopyThisYearsCategoriesAndActualsAsBudget.Select(1)
					[ ] DlgAddABudgetForNextOrPreviousYear.OKButton.Click()
					[ ] 
					[ ] QuickenWindow.SetActive()
					[ ] ///Verify that budget has been extended as expected.
					[ ] //
					[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
					[ ] iListCount= MDIClient.Budget.ListBox.GetItemCount() +1
					[ ] 
					[+] for (iCounter=1 ; iCounter<=12;++iCounter)
						[ ] sActualMonth=MDIClient.Budget.CurrentMonthStaticText.GetText()
						[+] for( iListCounter=1; iListCounter <=ListCount (lsCategoryList) ; iListCounter++)
							[ ] iBudgetAmount=VAL(lsCategoryBudget[iListCounter])
							[ ] sCategory=trim(lsCategoryList[iListCounter])
							[+] for (iCount=1 ; iCount<=iListCount;++iCount)
								[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
								[ ] bMatch = MatchStr("*{sCategory}*{iBudgetAmount}*", sActual)
								[+] if (bMatch)
									[ ] break
							[+] if(bMatch)
								[ ] ReportStatus("Verify extending the current year categories and budget to previous year." ,PASS, "The budget for month:{sActualMonth} has been updated:{sActual} as expected:{iBudgetAmount} for category: {sCategory} on Graph view.")
							[+] else
								[ ] ReportStatus("Verify extending the current year categories and budget to previous year." ,FAIL, "The budget for month:{sActualMonth} couldn't be updated:{sActual} as expected:{iBudgetAmount} for category: {sCategory} on Graph view.")
						[ ] 
						[ ] //go to previous month
						[+] if (iCounter<12)
							[ ] MDIClient.Budget.BackWardMonthButton.Click()
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify the Budget can be extended to next year." , FAIL, "Dialog:{sActual} didn't appear.")
				[ ] 
				[ ] ////Create budget for Next year
				[ ] QuickenWindow.SetActive()
				[ ] sleep(2)
				[ ] 
				[+] while (!DlgAddABudgetForNextOrPreviousYear.Exists())
					[ ] MDIClient.Budget.ForwardMonthButton.Click()
					[ ] ///Extend budget for next year using second option
				[+] if (DlgAddABudgetForNextOrPreviousYear.Exists(5))
					[ ] DlgAddABudgetForNextOrPreviousYear.SetActive()
					[ ] sActual =DlgAddABudgetForNextOrPreviousYear.GetProperty("Caption")
					[ ] DlgAddABudgetForNextOrPreviousYear.RadioListCopyThisYearsCategories.Select(3)
					[ ] DlgAddABudgetForNextOrPreviousYear.OKButton.Click()
					[ ] 
					[ ] QuickenWindow.SetActive()
					[ ] ///Verify that budget has been extended as expected.
					[ ] //
					[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
					[ ] iListCount= MDIClient.Budget.ListBox.GetItemCount() +1
					[ ] 
					[+] for (iCounter=1 ; iCounter<=12;++iCounter)
						[ ] sActualMonth=MDIClient.Budget.CurrentMonthStaticText.GetText()
						[+] for( iListCounter=1; iListCounter <=ListCount (lsCategoryList) ; iListCounter++)
							[ ] sCategory=trim(lsCategoryList[iListCounter])
							[+] for (iCount=1 ; iCount<=iListCount;++iCount)
								[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
								[ ] bMatch = MatchStr("*{sCategory}*", sActual)
								[+] if (bMatch)
									[ ] break
							[+] if(bMatch)
								[ ] ReportStatus("Verify extending the current budget categories to Next year." ,PASS, "The category: {sActual} has been extended as expected: {sCategory} for month:{sActualMonth} on Graph view.")
							[+] else
								[ ] ReportStatus("Verify extending the current budget categories to Next year." ,FAIL, "The category: {sCategory} couldn't be extended as expected: {sCategory} for month:{sActualMonth} on Graph view.")
						[ ] 
						[ ] //go to previous month
						[+] if (iCounter<12)
							[ ] MDIClient.Budget.ForwardMonthButton.Click()
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify the Budget can be extended to next year." , FAIL, "Dialog:{sActual} didn't appear.")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify budget gets added.", FAIL, "Budget: {sBudgetName} couldn't be added.")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify budget gets deleted.", FAIL, "Budget: {sBudgetName} couldn't be deleted.")
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
[ ] 
[+] //##########Test 47: Align Expand All/Collapse all buttons with report. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test47_VerifyExpandAllAndCollapseAllFeatureForReport
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that expand all / collapse all buttons expands/collapses the subcategories on report
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If expand all / collapse all buttons expands/collapses the subcategories on report
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  June 24  2014
		[ ] //
	[ ] // ********************************************************
[ ] 
[+] testcase Test47_VerifyExpandAllAndCollapseAllFeatureForReport() appstate none
	[+] //--------------Variable Declaration-------------
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] 
		[ ] lsCategoryList = lsExcelData[1]
		[ ] sCategoryType=trim(lsCategoryList[1])
		[ ] sParentCategory=trim(lsCategoryList[2])
		[ ] 
		[ ] lsCategoryList = lsExcelData[1]
		[ ] lsCategoryBudget= lsExcelData[3]
		[ ] iTotalBudget=0
		[ ] ///Remove NULL from the lists
		[ ] sCurrentMonth=FormatDateTime(GetDateTime(), "m") 
		[+] for( iCounter=1; iCounter <=ListCount (lsCategoryList) ; iCounter++)
			[+] if (lsCategoryList[iCounter]==NULL)
				[ ] ListDelete (lsCategoryList ,iCounter)
				[ ] iCounter--
				[ ] 
		[ ] 
		[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iResult=DeleteBudget()
		[+] if (iResult==PASS)
			[ ] iResult=AddBudget(sBudgetName)
			[+] if (iResult==PASS)
				[ ] ReportStatus("Verify budget gets added.", PASS, "Budget: {sBudgetName} has been added.")
				[ ] 
				[ ] //// Set Parent rollup on
				[ ] SelectBudgetOptionOnGraphAnnualView(sGraphView,"Rollup")
				[ ] 
				[ ] 
				[ ] ///replace category type personal expenses with EXPENSES
				[ ] ListDelete(lsCategoryList,1)
				[ ] ListInsert(lsCategoryList,1,"EXPENSES")
				[ ] 
				[ ] 
				[ ] ////Verify that expand all / collapse all buttons expands/collapses the subcategories on Historical Budget report
				[ ] ///Select Historical Budget report on Graph View
				[ ] 
				[ ] SelectBudgetReportOnGraphView(sREPORT_HISTORICAL_BUDGET)
				[+] if (HistoricalBudget.Exists(2))
					[ ] HistoricalBudget.SetActive()
					[ ] HistoricalBudget.Maximize()
					[ ] 
					[ ] ////Verify that clicking Expand All button expands all the subcategories in the report
					[ ] HistoricalBudget.ExpandAll.Click()
					[+] for(iCount= 1; iCount <= ListCount (lsCategoryList);  iCount++)
						[ ] 
						[ ] sCategory=lsCategoryList[iCount]
						[+] do 
							[ ] HistoricalBudget.ListBox.TextClick(sCategory)
							[ ] ReportStatus("Verify that clicking Expand All button expands all the subcategories in the report.", PASS ,"Category: {sCategory} displayed after clicking Expand All button on report: {sREPORT_HISTORICAL_BUDGET} .")
						[+] except
							[ ] ReportStatus("Verify that clicking Expand All button expands all the subcategories in the report.", FAIL ,"Category: {sCategory} didn't display after clicking Expand All button on report: {sREPORT_HISTORICAL_BUDGET}.")
					[ ] 
					[ ] ////Verify that clicking Collapse All button expands all the subcategories in the report
					[ ] HistoricalBudget.CollapseAll.Click()
					[+] for(iCount= 1; iCount <= ListCount (lsCategoryList);  iCount++)
						[ ] 
						[ ] sCategory=lsCategoryList[iCount]
						[+] if (iCount==1)
							[ ] 
							[+] do 
								[ ] HistoricalBudget.ListBox.TextClick(sCategory)
								[ ] ReportStatus("Verify that clicking Collapse All button only displays the category type on the report.", PASS ,"Category Type: {sCategory} displayed after clicking Collapse All button on report: {sREPORT_HISTORICAL_BUDGET}.")
								[ ] 
							[+] except
								[ ] ReportStatus("Verify that clicking Collapse All button only displays the category type on the report.", FAIL ,"Category Type: {sCategory} didn't display after clicking Collapse All button on report: {sREPORT_HISTORICAL_BUDGET}.")
								[ ] 
						[+] else
							[+] do 
								[ ] HistoricalBudget.ListBox.TextClick(sCategory)
								[ ] ReportStatus("Verify that clicking Collapse All button collapses all the subcategories in the report.", FAIL ,"Category: {sCategory} displayed after clicking Collapse All button on report: {sREPORT_HISTORICAL_BUDGET}.")
							[+] except
								[ ] ReportStatus("Verify that clicking Collapse All button collapses all the subcategories in the report.", PASS ,"Category: {sCategory} didn't display after clicking Collapse All button on report: {sREPORT_HISTORICAL_BUDGET}.")
								[ ] 
							[ ] 
					[ ] 
					[ ] HistoricalBudget.SetActive()
					[ ] HistoricalBudget.Close()
					[ ] WaitForState(HistoricalBudget , False ,2)
				[+] else
					[ ] ReportStatus("Verify report: {sREPORT_CURRENT_BUDGET} on budget Graph View.", FAIL , " {sREPORT_CURRENT_BUDGET} on budget Graph View didn't appear.") 
					[ ] 
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] ////Verify that expand all / collapse all buttons expands/collapses the subcategories on Current Budget report
				[ ] ///Select Current Budget report on Graph View
				[ ] 
				[ ] SelectBudgetReportOnGraphView(sREPORT_CURRENT_BUDGET)
				[+] if (CurrentBudget.Exists(2))
					[ ] CurrentBudget.SetActive()
					[ ] CurrentBudget.Maximize()
					[ ] 
					[ ] ////Verify that clicking Expand All button expands all the subcategories in the report
					[ ] CurrentBudget.ExpandAll.Click()
					[+] for(iCount= 1; iCount <= ListCount (lsCategoryList);  iCount++)
						[ ] 
						[ ] sCategory=lsCategoryList[iCount]
						[+] do 
							[ ] CurrentBudget.ListBox.TextClick(sCategory)
							[ ] ReportStatus("Verify that clicking Expand All button expands all the subcategories in the report.", PASS ,"Category: {sCategory} displayed after clicking Expand All button on report: {sREPORT_CURRENT_BUDGET} .")
						[+] except
							[ ] ReportStatus("Verify that clicking Expand All button expands all the subcategories in the report.", FAIL ,"Category: {sCategory} didn't display after clicking Expand All button on report: {sREPORT_CURRENT_BUDGET}.")
					[ ] 
					[ ] ////Verify that clicking Collapse All button expands all the subcategories in the report
					[ ] CurrentBudget.CollapseAll.Click()
					[+] for(iCount= 1; iCount <= ListCount (lsCategoryList);  iCount++)
						[ ] 
						[ ] sCategory=lsCategoryList[iCount]
						[+] if (iCount==1)
							[ ] 
							[+] do 
								[ ] CurrentBudget.ListBox.TextClick(sCategory)
								[ ] ReportStatus("Verify that clicking Collapse All button only displays the category type on the report.", PASS ,"Category Type: {sCategory} displayed after clicking Collapse All button on report: {sREPORT_CURRENT_BUDGET}.")
								[ ] 
							[+] except
								[ ] ReportStatus("Verify that clicking Collapse All button only displays the category type on the report.", FAIL ,"Category Type: {sCategory} didn't display after clicking Collapse All button on report: {sREPORT_CURRENT_BUDGET}.")
								[ ] 
						[+] else
							[+] do 
								[ ] CurrentBudget.ListBox.TextClick(sCategory)
								[ ] ReportStatus("Verify that clicking Collapse All button collapses all the subcategories in the report.", FAIL ,"Category: {sCategory} displayed after clicking Collapse All button on report: {sREPORT_HISTORICAL_BUDGET}.")
							[+] except
								[ ] ReportStatus("Verify that clicking Collapse All button collapses all the subcategories in the report.", PASS ,"Category: {sCategory} didn't display after clicking Collapse All button on report: {sREPORT_HISTORICAL_BUDGET}.")
								[ ] 
							[ ] 
					[ ] 
					[ ] CurrentBudget.SetActive()
					[ ] CurrentBudget.Close()
					[ ] WaitForState(CurrentBudget , False ,2)
				[+] else
					[ ] ReportStatus("Verify report: {sREPORT_CURRENT_BUDGET} on budget Graph View.", FAIL , " {sREPORT_CURRENT_BUDGET} on budget Graph View didn't appear.") 
					[ ] 
					[ ] 
					[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify budget gets added.", FAIL, "Budget: {sBudgetName} couldn't be added.")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify budget gets deleted.", FAIL, "Budget: {sBudgetName} couldn't be deleted.")
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
[ ] 
[+] //##########Test 48: Total category group name with all caps and bold. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test48_VerifyTotalCategoryGroupIsInCapitalsInReport
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that Total category group name is in all caps and bold in report
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Total category group name is in all caps and bold in report
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  June 24  2014
		[ ] //
	[ ] // ********************************************************
[ ] 
[+] testcase Test48_VerifyTotalCategoryGroupIsInCapitalsInReport() appstate none
	[+] //--------------Variable Declaration-------------
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] 
		[ ] lsCategoryList = lsExcelData[1]
		[ ] sCategoryType=trim(lsCategoryList[1])
		[ ] sParentCategory=trim(lsCategoryList[2])
		[ ] 
		[ ] //Get Income category
		[ ] sIncomeCategoryType=trim( lsExcelData[3][1])
		[ ] sIncomeCategory=trim( lsExcelData[3][2])
		[ ] 
		[ ] ///Remove NULL from the lists
		[ ] sCurrentMonth=FormatDateTime(GetDateTime(), "m") 
		[+] for( iCounter=1; iCounter <=ListCount (lsCategoryList) ; iCounter++)
			[+] if (lsCategoryList[iCounter]==NULL)
				[ ] ListDelete (lsCategoryList ,iCounter)
				[ ] iCounter--
				[ ] 
		[ ] 
		[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //Add income category to budget
		[ ] SelectOneCategoryToBudget(sIncomeCategoryType ,sIncomeCategory)
		[ ] 
		[ ] 
		[ ] ////Verify that Total category group name is in all caps and bold in Historical Budget report
		[ ] ///Select Historical Budget report on Graph View
		[ ] 
		[ ] SelectBudgetReportOnGraphView(sREPORT_HISTORICAL_BUDGET)
		[+] if (HistoricalBudget.Exists(2))
			[ ] HistoricalBudget.SetActive()
			[ ] HistoricalBudget.Maximize()
			[ ] 
			[ ] ////Verify that Income category group name is in all caps and bold in Historical Budget report
			[+] do 
				[ ] HistoricalBudget.ListBox.TextClick(Upper(sIncomeCategoryGroup))
				[ ] ReportStatus("Verify that Income category group name is in all caps in report.", PASS ,"Income category group: {Upper(sIncomeCategoryGroup)} displayed in capitals on report: {sREPORT_HISTORICAL_BUDGET} .")
			[+] except
				[ ] ReportStatus("Verify that Income category group name is in all caps in report.", FAIL ,"Income category group: {Upper(sIncomeCategoryGroup)} didn't display in capitals on report: {sREPORT_HISTORICAL_BUDGET} .")
			[ ] 
			[ ] ////Verify that Expenses category group name is in all caps and bold in Historical Budget report
			[+] do 
				[ ] HistoricalBudget.ListBox.TextClick(Upper(sExpensesCategoryGroup))
				[ ] ReportStatus("Verify that Expenses category group name is in all caps in report.", PASS ,"Expenses category group: {Upper(sExpensesCategoryGroup)} displayed in capitals on report: {sREPORT_HISTORICAL_BUDGET} .")
			[+] except
				[ ] ReportStatus("Verify that Expenses category group name is in all caps in report.", FAIL ,"Expenses category group: {Upper(sExpensesCategoryGroup)} didn't display in capitals on report: {sREPORT_HISTORICAL_BUDGET} .")
			[ ] 
			[ ] 
			[ ] HistoricalBudget.SetActive()
			[ ] HistoricalBudget.Close()
			[ ] WaitForState(HistoricalBudget , False ,2)
		[+] else
			[ ] ReportStatus("Verify report: {sREPORT_CURRENT_BUDGET} on budget Graph View.", FAIL , " {sREPORT_CURRENT_BUDGET} on budget Graph View didn't appear.") 
			[ ] 
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] ////Verify that Total category group name is in all caps and bold in Current Budget report
		[ ] ///Select Current Budget report on Graph View
		[ ] 
		[ ] SelectBudgetReportOnGraphView(sREPORT_CURRENT_BUDGET)
		[+] if (CurrentBudget.Exists(2))
			[ ] CurrentBudget.SetActive()
			[ ] CurrentBudget.Maximize()
			[ ] 
			[ ] ////Verify that Income category group name is in all caps and bold in Current Budget report
			[+] do 
				[ ] CurrentBudget.ListBox.TextClick(Upper(sIncomeCategoryGroup))
				[ ] ReportStatus("Verify that Income category group name is in all caps in report.", PASS ,"Income category group: {Upper(sIncomeCategoryGroup)} displayed in capitals on report: {sREPORT_CURRENT_BUDGET} .")
			[+] except
				[ ] ReportStatus("Verify that Income category group name is in all caps in report.", FAIL ,"Income category group: {Upper(sIncomeCategoryGroup)} didn't display in capitals on report: {sREPORT_CURRENT_BUDGET} .")
			[ ] 
			[ ] ////Verify that Expenses category group name is in all caps and bold in Current Budget report
			[+] do 
				[ ] CurrentBudget.ListBox.TextClick(Upper(sIncomeCategoryGroup))
				[ ] ReportStatus("Verify that Expenses category group name is in all caps in report.", PASS ,"Expenses category group: {Upper(sExpensesCategoryGroup)} displayed in capitals on report: {sREPORT_CURRENT_BUDGET} .")
			[+] except
				[ ] ReportStatus("Verify that Expenses category group name is in all caps in report.", FAIL ,"Expenses category group: {Upper(sExpensesCategoryGroup)} didn't display in capitals on report: {sREPORT_CURRENT_BUDGET} .")
			[ ] 
			[ ] 
			[ ] CurrentBudget.SetActive()
			[ ] CurrentBudget.Close()
			[ ] WaitForState(CurrentBudget , False ,2)
		[+] else
			[ ] ReportStatus("Verify report: {sREPORT_CURRENT_BUDGET} on budget Graph View.", FAIL , " {sREPORT_CURRENT_BUDGET} on budget Graph View didn't appear.") 
			[ ] 
			[ ] 
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
[ ] 
[+] //##########Test 52: Color “Actual” value as hyperlink by default. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test52_VerifyActualVauesAreHyperlinksInReport
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that Color “Actual” value as hyperlink by default in report
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Color “Actual” value are hyperlink by default in report
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  June 25  2014
		[ ] //
	[ ] // ********************************************************
[ ] 
[+] testcase Test52_VerifyActualVauesAreHyperlinksInReport() appstate none
	[+] //--------------Variable Declaration-------------
		[ ] 
		[ ] 
		[ ] lsTxnExcelData=NULL
		[ ] lsTxnExcelData=ReadExcelTable(sBudgetExcelsheet, sRegTransactionSheet)
		[ ] 
		[ ] 
		[ ] //Calculate transaction months
		[ ] sCurrentMonth=FormatDateTime(GetDateTime(), "m") 
		[ ] iCurrentMonth=VAL(sCurrentMonth)
		[ ] iTxnMonths=4
		[+] if (iCurrentMonth<=4)
			[ ] iTxnMonths=iCurrentMonth
		[ ] 
		[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //Calculate total expense for t
		[+] for (iCounter=3 ;  iCounter<= 3; iCounter++)
			[ ] lsTransaction=lsTxnExcelData[iCounter]
			[+] if(lsTransaction[1]==NULL)
				[ ] break
			[ ] 
			[ ] sCategory=lsTransaction[8]
			[ ] iTxnAmount=VAL(lsTransaction[3])
			[ ] iTotalExpense=iTxnAmount*iTxnMonths
			[ ] 
			[ ] ////Verify actuals are hyperlink in the Historical Budget report
			[ ] ///Select Historical Budget report on Graph View
			[ ] 
			[ ] SelectBudgetReportOnGraphView(sREPORT_HISTORICAL_BUDGET)
			[+] if (HistoricalBudget.Exists(2))
				[ ] HistoricalBudget.SetActive()
				[ ] HistoricalBudget.Maximize()
				[ ] ///Click the total actual value
				[ ] HistoricalBudget.ListBox.TextClick(Str(iTotalExpense))
				[ ] sleep(2)
				[ ] sHandle= Str(HistoricalBudget.ListBox.GetHandle())
				[ ] iListCount =HistoricalBudget.ListBox.GetItemCount() 
				[+] for(iCount= 1; iCount <= iListCount;  iCount++)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount-1))
					[ ] bMatch = MatchStr("*{iTotalExpense}*", sActual)
					[+] if (bMatch)
						[ ] break
				[+] if (bMatch)
					[ ] ReportStatus("Verify actuals are hyperlink in the report.", PASS ,"Clicking on actual value: {iTotalExpense} for Category: {sCategory} took user to expected transactions:{sActual} on report: {sREPORT_HISTORICAL_BUDGET}.")
				[+] else
					[ ] ReportStatus("Verify actuals are hyperlink in the report.", FAIL ,"Clicking on actual value: {iTotalExpense} for Category: {sCategory} didn't take user to expected transactions as actual is:{sActual} on report: {sREPORT_HISTORICAL_BUDGET}.")
				[ ] 
				[ ] 
				[ ] HistoricalBudget.SetActive()
				[ ] HistoricalBudget.Close()
				[ ] WaitForState(HistoricalBudget , False ,2)
			[+] else
				[ ] ReportStatus("Verify report: {sREPORT_CURRENT_BUDGET} on budget Graph View.", FAIL , " {sREPORT_CURRENT_BUDGET} on budget Graph View didn't appear.") 
				[ ] 
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] ////Verify actuals are hyperlink in the Current Budget report
			[ ] ///Select Current Budget report on Graph View
			[ ] 
			[ ] SelectBudgetReportOnGraphView(sREPORT_CURRENT_BUDGET)
			[+] if (CurrentBudget.Exists(2))
				[ ] CurrentBudget.SetActive()
				[ ] CurrentBudget.Maximize()
				[ ] CurrentBudget.ListBox.TextClick(Str(iTotalExpense))
				[ ] sleep(2)
				[ ] sHandle= Str(CurrentBudget.ListBox.GetHandle())
				[ ] iListCount =CurrentBudget.ListBox.GetItemCount() 
				[+] for(iCount= 1; iCount <= iListCount;  iCount++)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount-1))
					[ ] bMatch = MatchStr("*{iTotalExpense}*", sActual)
					[+] if (bMatch)
						[ ] break
				[+] if (bMatch)
					[ ] ReportStatus("Verify actuals are hyperlink in the report.", PASS ,"Clicking on actual value: {iTotalExpense} for Category: {sCategory} took user to expected transactions:{sActual} on report: {sREPORT_CURRENT_BUDGET}.")
				[+] else
					[ ] ReportStatus("Verify actuals are hyperlink in the report.", FAIL ,"Clicking on actual value: {iTotalExpense} for Category: {sCategory} didn't take user to expected transactions as actual is:{sActual} on report: {sREPORT_CURRENT_BUDGET}.")
				[ ] 
				[ ] CurrentBudget.SetActive()
				[ ] CurrentBudget.Close()
				[ ] WaitForState(CurrentBudget , False ,2)
			[+] else
				[ ] ReportStatus("Verify report: {sREPORT_CURRENT_BUDGET} on budget Graph View.", FAIL , " {sREPORT_CURRENT_BUDGET} on budget Graph View didn't appear.") 
				[ ] 
				[ ] 
				[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
[ ] 
[+] //##########Test 53: As a user, I want a view the months of future year in the Annual display same as current months. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test53_VerifyThatCurrentYearsRolloverGetsCarriedToFutureYear
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that current year's rollover gets carried to future year
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If current year's rollover gets carried to future year.
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  June 26 2014
		[ ] ///Note : TestCase not availble in updated sheet
	[ ] // ********************************************************
[ ] 
[+] testcase Test53_VerifyThatCurrentYearsRolloverGetsCarriedToFutureYear() appstate none
	[ ] 
	[+] //--------------Variable Declaration------------
		[ ] 
		[ ] INTEGER iTotalFutureYearBudget ,iTotalFutureYearBudgetWithRollover ,iFutureCatTotalRolloverAmount
		[ ] STRING sActualYear
		[ ] bMatch=FALSE
		[ ] iBudgetAmount=50
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] lsCategoryList=lsExcelData[1]
		[ ] sCategory=lsCategoryList[3]
		[ ] // Fetch 1st row from sRegTransactionSheet the given sheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sRegTransactionSheet)
		[ ] lsTransaction=lsExcelData[1]
		[ ] iTxnAmount=VAL(lsTransaction[3])
		[ ] 
		[ ] sCurrentMonth=FormatDateTime(GetDateTime(), "m") //Get current month as January 2014
		[ ] iCurrentMonth = VAL(sCurrentMonth)
		[ ] iRollOverMonthCount=4
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
		[+] if (iResult==PASS)
			[ ] sleep(2)
			[ ] iResult=DeleteBudget()
			[+] if (iResult==PASS)
				[ ] iResult=AddBudget(sBudgetName)
				[+] if (iResult==PASS)
					[ ] ReportStatus("Verify budget gets added.", PASS, "Budget: {sBudgetName} has been added.")
					[ ] 
					[ ] QuickenWindow.SetActive()
					[ ] 
					[ ] 
					[ ] //// Set Parent rollup on
					[ ] SelectBudgetOptionOnGraphAnnualView(sGraphView,"Rollup")
					[ ] sleep(2)
					[ ] iResult=AddAverageBudget(sCategory ,iBudgetAmount)
					[+] if (iResult==PASS)
						[ ] QuickenWindow.SetActive()
						[ ] ///Enable Rollover 
						[ ] SelectDeselectRollOverOptions (sCategory, sSetRollOverBalance)
						[ ] QuickenWindow.SetActive()
						[ ] ////Select annual view on budget
						[ ] lsRolloverData = CreateRollOverData(  sCategory, iBudgetAmount ,  iTxnAmount)
						[ ] sExpectedNoTxnRollOverAmount =lsRolloverData[2]
						[ ] sExpectedTxnRollOverAmount =lsRolloverData[3]
						[ ] iCatTotalRolloverAmount=lsRolloverData[1]
						[ ] 
						[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sAnnualView)
						[ ] sleep(4)
						[ ] QuickenWindow.SetActive()
						[ ] MDIClient.Budget.AnnualViewTypeComboBox.Select("Balance only")
						[ ] sleep(2)
						[ ] QuickenWindow.SetActive()
						[+] if (MDIClient.Budget.ShowBalanceInFutureMonthsCheckBox.Exists(2))
							[ ] MDIClient.Budget.ShowBalanceInFutureMonthsCheckBox.Check()
							[ ] 
						[ ] 
						[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
						[ ] iListCount= MDIClient.Budget.ListBox.GetItemCount() +1
						[+] for (iCount=2 ; iCount<=iListCount;++iCount)
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
							[ ] bMatch = MatchStr("*{sExpectedNoTxnRollOverAmount}*{sExpectedTxnRollOverAmount}*{iCatTotalRolloverAmount}*", StrTran(sActual,",",""))
							[+] if (bMatch)
								[ ] break
						[+] if(bMatch)
							[ ] ReportStatus("Verify that Category Total Balance values on Annual view should include rollover." ,PASS, "The Category Total Balance values on Annual view included rollover for category: {sCategory} on Annual View as expected:{sExpectedNoTxnRollOverAmount}, {sExpectedTxnRollOverAmount},{iCatTotalRolloverAmount}*.")
						[+] else
							[ ] ReportStatus("Verify that Category Total Balance values on Annual view should include rollover." ,FAIL, "The Category Total Balance values on Annual view didn't include the rollover for category: {sCategory} on Annual View as actual: {sActual} is not as expected:{sExpectedNoTxnRollOverAmount}, {sExpectedTxnRollOverAmount},{iCatTotalRolloverAmount}*.")
						[ ] 
						[ ] QuickenWindow.SetActive()
						[ ] MDIClient.Budget.ForwardMonthButton.Click()
						[ ] ///Extend budget for next year using second option
						[+] if (DlgAddABudgetForNextOrPreviousYear.Exists(5))
							[ ] DlgAddABudgetForNextOrPreviousYear.SetActive()
							[ ] sActual =DlgAddABudgetForNextOrPreviousYear.GetProperty("Caption")
							[ ] DlgAddABudgetForNextOrPreviousYear.RadioListCopyThisYearsCategoriesAndActualsAsBudget.Select(1)
							[ ] DlgAddABudgetForNextOrPreviousYear.OKButton.Click()
							[ ] 
							[ ] QuickenWindow.SetActive()
							[ ] 
							[ ] ///Calculate future year budget
							[ ] iTotalFutureYearBudget =12*iBudgetAmount
							[ ] //Future year budget with rollover 
							[ ] iTotalFutureYearBudgetWithRollover=iTotalFutureYearBudget + iCatTotalRolloverAmount
							[ ] ///monthly budget expected pattern
							[ ] iFutureCatTotalRolloverAmount=iCatTotalRolloverAmount
							[ ] sExpectedPattern=""
							[+] for (iCounter=1 ; iCounter<=12;++iCounter)
								[ ] iFutureCatTotalRolloverAmount=iFutureCatTotalRolloverAmount+iBudgetAmount
								[ ] sExpectedPattern =sExpectedPattern+"*{iFutureCatTotalRolloverAmount}*"
							[ ] ///Verify that budget has been extended as expected.
							[ ] //
							[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
							[ ] iListCount= MDIClient.Budget.ListBox.GetItemCount() +1
							[ ] 
							[ ] sActualYear=MDIClient.Budget.CurrentMonthStaticText.GetText()
							[+] for (iCount=2 ; iCount<=iListCount;++iCount)
								[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
								[ ] bMatch = MatchStr("*{sExpectedPattern}*{iFutureCatTotalRolloverAmount}*", StrTran(sActual,",",""))
								[+] if (bMatch)
									[ ] break
							[+] if(bMatch)
								[ ] ReportStatus("Verify that current year's rollover get extended to future year." ,PASS, "The category budget values for Future year:{sActualYear} on Annual view included rollover from current year for category: {sCategory} on Annual View as expected: {sExpectedPattern}, {iFutureCatTotalRolloverAmount}.")
							[+] else
								[ ] ReportStatus("Verify that current year's rollover get extended to future year.." ,FAIL, "The category budget values for Future year:{sActualYear} on Annual view didn't include rollover from current year for category: {sCategory} on Annual View as actual: {sActual} is not as expected:  {sExpectedPattern}, {iFutureCatTotalRolloverAmount}.")
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify the Budget can be extended to next year." , FAIL, "Dialog:{sActual} didn't appear.")
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify that User is able to add average budget for category: {sCategory} with amount: {iBudgetAmount}."  , FAIL,"Average budget for category: {sCategory} with amount: {iBudgetAmount} couldn't be added for 12 months on Graph View.")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify budget gets added.", FAIL, "Budget: {sBudgetName} couldn't be added.")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify budget gets deleted.", FAIL, "Budget: {sBudgetName} couldn't be deleted.")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
	[ ] 
[ ] 
[+] //##########Test 54: Verify Past year's rollover carried forward to the current year in the Annual display.. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test54_VerifyThatPastYearsRolloverGetsCarriedToCurrentYear
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that last year's rollover gets carried to current year
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If last year's rollover gets carried to current year
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  July 09 2014
	[ ] // ********************************************************
[ ] 
[+] testcase Test54_VerifyThatPastYearsRolloverGetsCarriedToCurrentYear() appstate none
	[ ] 
	[+] //--------------Variable Declaration------------
		[ ] 
		[ ] INTEGER iPastMonths ,iPastYearRollOverAmount ,iPastYearTxnAmount
		[ ] STRING sActualYear
		[ ] bMatch=FALSE
		[ ] iBudgetAmount=50
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] lsCategoryList=lsExcelData[1]
		[ ] sCategory=lsCategoryList[3]
		[ ] // Fetch 1st row from sRegTransactionSheet the given sheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sRegTransactionSheet)
		[ ] lsTransaction=lsExcelData[1]
		[ ] iTxnAmount=VAL(lsTransaction[3])
		[ ] 
		[ ] sCurrentMonth=FormatDateTime(GetDateTime(), "m") //Get current month as January 2014
		[ ] iCurrentMonth = VAL(sCurrentMonth)
		[ ] iRollOverMonthCount=4
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
		[+] if (iResult==PASS)
			[ ] sleep(2)
			[ ] iResult=DeleteBudget()
			[+] if (iResult==PASS)
				[ ] iResult=AddBudget(sBudgetName)
				[+] if (iResult==PASS)
					[ ] ReportStatus("Verify budget gets added.", PASS, "Budget: {sBudgetName} has been added.")
					[ ] 
					[ ] QuickenWindow.SetActive()
					[ ] 
					[ ] 
					[ ] //// Set Parent rollup on
					[ ] SelectBudgetOptionOnGraphAnnualView(sGraphView,"Rollup")
					[ ] sleep(2)
					[ ] iResult=AddAverageBudget(sCategory ,iBudgetAmount)
					[+] if (iResult==PASS)
						[ ] QuickenWindow.SetActive()
						[ ] ///Enable Rollover 
						[ ] SelectDeselectRollOverOptions(sCategory, sSetRollOverBalance )
						[ ] QuickenWindow.SetActive()
						[ ] ////Select annual view on budget
						[ ] lsRolloverData = CreateRollOverData(  sCategory, iBudgetAmount ,  iTxnAmount)
						[ ] sExpectedNoTxnRollOverAmount =lsRolloverData[2]
						[ ] sExpectedTxnRollOverAmount =lsRolloverData[3]
						[ ] iCatTotalRolloverAmount=lsRolloverData[1]
						[ ] 
						[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sAnnualView)
						[ ] sleep(4)
						[ ] QuickenWindow.SetActive()
						[ ] MDIClient.Budget.AnnualViewTypeComboBox.Select("Balance only")
						[ ] sleep(2)
						[ ] QuickenWindow.SetActive()
						[+] if (MDIClient.Budget.ShowBalanceInFutureMonthsCheckBox.Exists(2))
							[ ] MDIClient.Budget.ShowBalanceInFutureMonthsCheckBox.Check()
							[ ] 
						[ ] 
						[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
						[ ] iListCount= MDIClient.Budget.ListBox.GetItemCount() +1
						[+] for (iCount=2 ; iCount<=iListCount;++iCount)
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
							[ ] bMatch = MatchStr("*{sExpectedNoTxnRollOverAmount}*{sExpectedTxnRollOverAmount}*{iCatTotalRolloverAmount}*", StrTran(sActual,",",""))
							[+] if (bMatch)
								[ ] break
						[+] if(bMatch)
							[ ] ReportStatus("Verify that Category Total Balance values on Annual view should include rollover." ,PASS, "The Category Total Balance values on Annual view included rollover for category: {sCategory} on Annual View as expected:{sExpectedNoTxnRollOverAmount}, {sExpectedTxnRollOverAmount},{iCatTotalRolloverAmount}*.")
						[+] else
							[ ] ReportStatus("Verify that Category Total Balance values on Annual view should include rollover." ,FAIL, "The Category Total Balance values on Annual view didn't include the rollover for category: {sCategory} on Annual View as actual: {sActual} is not as expected:{sExpectedNoTxnRollOverAmount}, {sExpectedTxnRollOverAmount},{iCatTotalRolloverAmount}*.")
						[ ] // valar morghulis
						[ ] QuickenWindow.SetActive()
						[ ] MDIClient.Budget.BackWardMonthButton.Click()
						[ ] ///Extend budget for next year using second option
						[+] if (DlgAddABudgetForNextOrPreviousYear.Exists(5))
							[ ] DlgAddABudgetForNextOrPreviousYear.SetActive()
							[ ] sActual =DlgAddABudgetForNextOrPreviousYear.GetProperty("Caption")
							[ ] DlgAddABudgetForNextOrPreviousYear.RadioListCopyThisYearsCategoriesAndActualsAsBudget.Select(1)
							[ ] DlgAddABudgetForNextOrPreviousYear.OKButton.Click()
							[ ] 
							[ ] 
							[ ] 
							[ ] 
							[ ] QuickenWindow.SetActive()
							[ ] 
							[ ] ///Now move back to the current year
							[ ] MDIClient.Budget.ForwardMonthButton.Click()
							[ ] MDIClient.Budget.AnnualViewTypeComboBox.Select("Balance only")
							[ ] sleep(2)
							[ ] 
							[+] ///create past months rollover data
								[ ] iTxnMonthCount=4
								[ ] iRollOverWithNoTxnMonthAmount=0
								[ ] iRemainingMonths=12 - iCurrentMonth
								[ ] iRemainingMonthsAmount=iRemainingMonths*iBudgetAmount
								[+] if (iCurrentMonth>4)
									[ ] iRollOverWithNoTxnMonthCount=iCurrentMonth-4
									[ ] iTxnMonthCount=4
								[+] else
									[ ] iTxnMonthCount= iCurrentMonth
									[ ] iRollOverWithNoTxnMonthCount=0
									[ ] 
								[ ] 
								[ ] ///past year rollover amount
								[ ] 
								[ ] iPastMonths =4-iTxnMonthCount
								[+] if (iPastMonths<1)
									[ ] iPastYearRollOverAmount = iBudgetAmount*12
								[+] else
									[ ] iPastYearTxnAmount = iPastMonths*iTxnAmount
									[ ] iPastYearRollOverAmount= (iBudgetAmount*12) - iPastYearTxnAmount
								[ ] 
								[ ] 
								[+] if (iTxnMonthCount>1)
									[ ] 
									[ ] ///Get rollover amounts for months for whom there are no transactions
									[+] if (iRollOverWithNoTxnMonthCount > 0)
										[ ] iExpectedNoTxnRollOverAmount=iBudgetAmount+iPastYearRollOverAmount
										[ ] sExpectedNoTxnRollOverAmount="*{iBudgetAmount+iPastYearRollOverAmount}*"
										[+] for (iCount=2; iCount<=iRollOverWithNoTxnMonthCount; iCount++)
											[ ] sExpectedNoTxnRollOverAmount =sExpectedNoTxnRollOverAmount +"*{iBudgetAmount+iExpectedNoTxnRollOverAmount}*"
											[ ] iExpectedNoTxnRollOverAmount=iBudgetAmount+iExpectedNoTxnRollOverAmount
									[+] else
										[ ] sExpectedNoTxnRollOverAmount=""
										[ ] iExpectedNoTxnRollOverAmount=iPastYearRollOverAmount
									[ ] 
									[ ] ///Get rollover amounts for months for whom there are  transactions
									[ ] iDiffOfBudgetTxnAmount= iBudgetAmount-iTxnAmount
									[ ] 
									[ ] iExpectedTxnRollOverAmount=iExpectedNoTxnRollOverAmount+iDiffOfBudgetTxnAmount
									[ ] sExpectedTxnRollOverAmount="*{str(iExpectedTxnRollOverAmount)}*"
									[+] for (iCount=2; iCount<=iTxnMonthCount; iCount++)
										[ ] 
										[ ] iExpectedTxnRollOverAmount=iExpectedTxnRollOverAmount + iDiffOfBudgetTxnAmount
										[ ] sExpectedTxnRollOverAmount =sExpectedTxnRollOverAmount +"*{iExpectedTxnRollOverAmount}*"
										[ ] 
										[ ] 
										[ ] 
									[ ] 
									[ ] iTotalRolloverAmount=iExpectedTxnRollOverAmount+iRemainingMonthsAmount
								[+] else
									[ ] iExpectedNoTxnRollOverAmount=0
									[ ] iExpectedTxnRollOverAmount=iPastYearRollOverAmount
									[ ] sExpectedNoTxnRollOverAmount="0"
									[ ] sExpectedTxnRollOverAmount="0"
									[ ] iTotalRolloverAmount=11*iBudgetAmount +iPastYearRollOverAmount
							[ ] 
							[ ] ///monthly budget expected pattern
							[ ] sExpectedPattern="*{sExpectedNoTxnRollOverAmount}*{sExpectedTxnRollOverAmount}*{iTotalRolloverAmount}*"
							[ ] ///Verify that budget has been extended as expected.
							[ ] //
							[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
							[ ] iListCount= MDIClient.Budget.ListBox.GetItemCount() +1
							[ ] 
							[ ] sActualYear=MDIClient.Budget.CurrentMonthStaticText.GetText()
							[+] for (iCount=2 ; iCount<=iListCount;++iCount)
								[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
								[ ] bMatch = MatchStr(sExpectedPattern, StrTran(sActual,",",""))
								[+] if (bMatch)
									[ ] break
							[+] if(bMatch)
								[ ] ReportStatus("Verify that last year's rollover get extended to current year." ,PASS, "The category budget values for current year:{sActualYear} on Annual view included rollover from past year for category: {sCategory} on Annual View as expected: {sExpectedPattern}")
							[+] else
								[ ] ReportStatus("Verify that last year's rollover get extended to current year.." ,FAIL, "The category budget values for current year:{sActualYear} on Annual view didn't include rollover from past year for category: {sCategory} on Annual View as actual: {sActual} is not as expected:  {sExpectedPattern}.")
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify the Budget can be extended to next year." , FAIL, "Dialog:{sActual} didn't appear.")
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify that User is able to add average budget for category: {sCategory} with amount: {iBudgetAmount}."  , FAIL,"Average budget for category: {sCategory} with amount: {iBudgetAmount} couldn't be added for 12 months on Graph View.")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify budget gets added.", FAIL, "Budget: {sBudgetName} couldn't be added.")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify budget gets deleted.", FAIL, "Budget: {sBudgetName} couldn't be deleted.")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
	[ ] 
[ ] 
[ ] 
[+] //##########Test 56: Applying Jan budget to all the months of the year. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test56_VerifyThatJanBudgetToAllTheMonthsOfTheYear
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that Jan's budget gets applied for all year
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Jan's budget gets applied for all year
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  July 09 2014
	[ ] // ********************************************************
[ ] 
[+] testcase Test56_VerifyThatJanBudgetToAllTheMonthsOfTheYear() appstate none
	[ ] 
	[+] //--------------Variable Declaration------------
		[ ] 
		[ ] INTEGER iTotalFutureYearBudget ,iTotalFutureYearBudgetWithRollover ,iFutureCatTotalRolloverAmount
		[ ] STRING sActualYear
		[ ] bMatch=FALSE
		[ ] iBudgetAmount=50
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] lsCategoryList=lsExcelData[1]
		[ ] sCategory=lsCategoryList[3]
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
		[+] if (iResult==PASS)
			[ ] sleep(2)
			[ ] iResult=DeleteBudget()
			[+] if (iResult==PASS)
				[ ] iResult=AddBudget(sBudgetName)
				[+] if (iResult==PASS)
					[ ] ReportStatus("Verify budget gets added.", PASS, "Budget: {sBudgetName} has been added.")
					[ ] 
					[ ] QuickenWindow.SetActive()
					[ ] 
					[ ] 
					[ ] //// Set Parent rollup on
					[ ] SelectBudgetOptionOnGraphAnnualView(sGraphView,"Rollup")
					[ ] sleep(2)
					[ ] QuickenWindow.SetActive()
					[ ] ///Enable Rollover 
					[ ] QuickenWindow.SetActive()
					[ ] ////Select annual view on budget
					[ ] 
					[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sAnnualView)
					[ ] sleep(4)
					[ ] QuickenWindow.SetActive()
					[ ] MDIClient.Budget.AnnualViewTypeComboBox.Select("Budget only")
					[ ] sleep(2)
					[ ] QuickenWindow.SetActive()
					[+] if (MDIClient.Budget.ShowBalanceInFutureMonthsCheckBox.Exists(2))
						[ ] MDIClient.Budget.ShowBalanceInFutureMonthsCheckBox.Check()
						[ ] 
					[ ] 
					[ ] //Set the amount for January
					[ ] MDIClient.Budget.TextClick(sCategory)
					[ ] MDIClient.Budget.ListBox.Amount.SetText(str(iBudgetAmount))
					[ ] MDIClient.Budget.ListBox.Amount.TypeKeys(KEY_TAB)
					[ ] 
					[ ] ///Apply this jan's budget for rest of the year
					[ ] QuickenWindow.TextClick("Jan",1,CT_RIGHT)
					[ ] QuickenWindow.TypeKeys(KEY_DN)
					[ ] QuickenWindow.TypeKeys(KEY_ENTER)
					[ ] sleep(1)
					[ ] ///Prepare the budget pattern
					[ ] sExpectedPattern=""
					[+] for (iCount=1; iCount<=12; iCount++)
						[ ] sExpectedPattern=sExpectedPattern+"*{iBudgetAmount}"
						[ ] 
					[ ] 
					[ ] 
					[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
					[ ] iListCount= MDIClient.Budget.ListBox.GetItemCount() +1
					[+] for (iCount=2 ; iCount<=iListCount;++iCount)
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
						[ ] bMatch = MatchStr("*{sExpectedPattern}*", sActual)
						[+] if (bMatch)
							[ ] break
					[+] if(bMatch)
						[ ] ReportStatus("Verify that Jan's budget gets applied for all year." ,PASS, "The Jan's budget has been applied for all year for category: {sCategory} on Annual View as expected:{sExpectedPattern}.")
					[+] else
						[ ] ReportStatus("Verify that Jan's budget gets applied for all year." ,FAIL, "The Jan's budget couldn't be applied for all year for category: {sCategory} on Annual View as actual: {sActual} is not as expected:{sExpectedPattern}.")
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify budget gets added.", FAIL, "Budget: {sBudgetName} couldn't be added.")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify budget gets deleted.", FAIL, "Budget: {sBudgetName} couldn't be deleted.")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
	[ ] 
[ ] // 
[+] //##########Test 58: As a user of the Annual View, I'd like a simple option for removing (or adding) a category from my budget (right-click). #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test58_VerifyAddingAndRemovingCategoryOptionsUsingRightClick
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that User should be able to access the add and remove category options via right-click menu.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If User should be able to access the add and remove category options via right-click menu.
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  April 15 2014
	[ ] // ********************************************************
[ ] 
[+] testcase Test58_VerifyAddingAndRemovingCategoryOptionsUsingRightClick() appstate none
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] STRING sRemoveCategory , sChooseCategories ,sCategoryTemp
		[ ] bMatch=FALSE
		[ ] sRemoveCategory= "Remove this category"
		[ ] sChooseCategories= "Choose categories"
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] lsCategoryList = lsExcelData[1]
		[ ] sCategoryType =trim(lsCategoryList[1])
		[ ] sCategory=trim(lsCategoryList[3])
		[ ] sCategoryTemp = trim(lsCategoryList[4])
		[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
		[+] if (iResult==PASS)
			[ ] sleep(2)
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] ////Select Graph View of budget
			[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sGraphView)
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] ///Verify Right Click menu options on Garph View
			[ ] // ////Verify "Remove Category" option from "Right Click " menu on Graph View
			[ ] iResult=SelectRightClickCategoryOptions(sCategory , sRemoveCategory)
			[+] if (iResult==PASS)
				[+] if(DlgRemoveCategory.Exists(5))
					[ ] DlgRemoveCategory.SetActive()
					[ ] DlgRemoveCategory.RemoveButton.Click()
					[ ] WaitForState(DlgRemoveCategory , False , 5)
					[+] do 
						[ ] MDIClient.Budget.ListBox.TextClick(sCategory)
						[ ] ReportStatus("Verify that User is able to Remove category via the right click menu." , FAIL,"The category: {sCategory} couldn't be removed using right click option{sRemoveCategory} on Graph View.")
					[+] except
						[ ] ReportStatus("Verify that User is able to Remove category via the right click menu." , PASS,"The category: {sCategory} has been removed using right click option{sRemoveCategory} on Graph View.")
					[ ] 
					[ ] ReportStatus("Verify that User is able to access the Remove this category option via the right click menu." , PASS,"{sRemoveCategory} dialog appeared via the right click menu on Graph View.")
				[+] else
					[ ] ReportStatus("Verify that User is able to access the Remove this category option via the right click menu.." , FAIL,"{sRemoveCategory} dialog didn't appear via the right click menu on Graph View.")
			[+] else
				[ ] ReportStatus("Verify Remove this category option from gear menu on Graph View selected." , FAIL, "Remove this category option from gear menu on Graph View couldn't be selected on Graph View.")
			[ ] 
			[ ] // ////Verify "Choose categories" option from "Right Click " menu on Graph View
			[ ] iResult=SelectRightClickCategoryOptions(sCategoryTemp , sChooseCategories)
			[+] if (iResult==PASS)
				[+] if (SelectCategoriesToBudget.Exists(4))
					[ ] SelectCategoriesToBudget.SetActive()
					[ ] SelectCategoriesToBudget.TextClick(sCategoryType)
					[ ] sHandle= Str(SelectCategoriesToBudget.ListBox.GetHandle())
					[ ] iListCount= SelectCategoriesToBudget.ListBox.GetItemCount() 
					[+] for(iCount= 0; iCount <= iListCount;  iCount++)
						[+] if (iCount>0)
							[+] if (SelectCategoriesToBudget.ListBox.VScrollBar.Exists())
								[ ] SelectCategoriesToBudget.ListBox.VScrollBar.ScrollByLine(1)
							[ ] 
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
						[ ] bMatch = MatchStr("*{trim(sCategory)}*", sActual)
						[+] if (bMatch)
							[+] if (SelectCategoriesToBudget.ListBox.VScrollBar.Exists())
								[ ] SelectCategoriesToBudget.ListBox.VScrollBar.ScrollByLine(-2)
							[ ] sleep(1)
							[ ] SelectCategoriesToBudget.TextClick(sCategory)
							[ ] break
						[ ] 
					[+] if (bMatch)
						[ ] ReportStatus("Verify Category found in the Select Categories To Budget dialog.", PASS, "Category:{sCategory} found in the Select Categories To Budget dialog on Graph View.")
					[+] else
						[ ] ReportStatus("Verify Category found in the Select Categories To Budget dialog.", FAIL, "Category:{sCategory} couldn't be found in the Select Categories To Budget dialog on Graph View.")
					[ ] 
					[ ] SelectCategoriesToBudget.OK.Click()
					[ ] WaitForState(SelectCategoriesToBudget , False ,3)
					[ ] 
					[ ] 
					[ ] 
					[+] do 
						[ ] MDIClient.Budget.ListBox.TextClick(sCategory)
						[ ] ReportStatus("Verify that User is able to add a category via the right click menu." , PASS,"The category: {sCategory} has been added using right click option{sRemoveCategory} on Graph View.")
					[+] except
						[ ] ReportStatus("Verify that User is able to add a category via the right click menu." , FAIL,"The category: {sCategory} couldn't be added using right click option{sRemoveCategory} on Graph View.")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Select Categories to Budget dialog appeared. ", FAIL , "Select Categories to Budget dialog didn't appear.") 
			[+] else
				[ ] ReportStatus("Verify Choose categories option using right click on Graph View selected." , FAIL, "Choose categories option using right click on Graph View couldn't be selected.")
			[ ] ////Select Annual View of budget
			[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sAnnualView)
			[ ] sleep(2)
			[ ] 
			[ ] ///Verify gear menu options on Annual View
			[ ] // ////Verify "Remove Category" option from "Right Click " menu on Annual View
			[ ] iResult=SelectRightClickCategoryOptions(sCategory , sRemoveCategory)
			[+] if (iResult==PASS)
				[+] if(DlgRemoveCategory.Exists(5))
					[ ] DlgRemoveCategory.SetActive()
					[ ] DlgRemoveCategory.RemoveButton.Click()
					[ ] WaitForState(DlgRemoveCategory , False , 5)
					[+] do 
						[ ] MDIClient.Budget.ListBox.TextClick(sCategory)
						[ ] ReportStatus("Verify that User is able to Remove category via the right click menu." , FAIL,"The category: {sCategory} couldn't be removed using right click option{sRemoveCategory} on Annual View.")
					[+] except
						[ ] ReportStatus("Verify that User is able to Remove category via the right click menu." , PASS,"The category: {sCategory} has been removed using right click option{sRemoveCategory} on Annual View.")
					[ ] 
					[ ] ReportStatus("Verify that User is able to access the Remove this category option via the right click menu." , PASS,"{sRemoveCategory} dialog appeared via the right click menu on Annual View.")
				[+] else
					[ ] ReportStatus("Verify that User is able to access the Remove this category option via the right click menu.." , FAIL,"{sRemoveCategory} dialog didn't appear via the right click menu on Annual View.")
			[+] else
				[ ] ReportStatus("Verify Remove this category option from gear menu on Graph View selected." , FAIL, "Remove this category option from gear menu on Graph View couldn't be selected on Annual View.")
			[ ] 
			[ ] // ////Verify "Choose categories" option from "Right Click " menu on Annual View
			[ ] iResult=SelectRightClickCategoryOptions(sCategoryTemp, sChooseCategories)
			[+] if (iResult==PASS)
				[+] if (SelectCategoriesToBudget.Exists(4))
					[ ] SelectCategoriesToBudget.SetActive()
					[ ] SelectCategoriesToBudget.TextClick(sCategoryType)
					[ ] sHandle= Str(SelectCategoriesToBudget.ListBox.GetHandle())
					[ ] iListCount= SelectCategoriesToBudget.ListBox.GetItemCount() 
					[+] for(iCount= 0; iCount <= iListCount;  iCount++)
						[+] if (iCount>0)
							[+] if (SelectCategoriesToBudget.ListBox.VScrollBar.Exists())
								[ ] SelectCategoriesToBudget.ListBox.VScrollBar.ScrollByLine(1)
							[ ] 
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
						[ ] bMatch = MatchStr("*{trim(sCategory)}*", sActual)
						[+] if (bMatch)
							[+] if (SelectCategoriesToBudget.ListBox.VScrollBar.Exists())
								[ ] SelectCategoriesToBudget.ListBox.VScrollBar.ScrollByLine(-2)
							[ ] sleep(1)
							[ ] SelectCategoriesToBudget.TextClick(sCategory)
							[ ] break
						[ ] 
					[+] if (bMatch)
						[ ] ReportStatus("Verify Category found in the Select Categories To Budget dialog.", PASS, "Category:{sCategory} found in the Select Categories To Budget dialog on Annual View.")
					[+] else
						[ ] ReportStatus("Verify Category found in the Select Categories To Budget dialog.", FAIL, "Category:{sCategory} couldn't be found in the Select Categories To Budget dialog on Annual View.")
					[ ] 
					[ ] SelectCategoriesToBudget.OK.Click()
					[ ] WaitForState(SelectCategoriesToBudget , False ,3)
					[ ] 
					[ ] 
					[+] do 
						[ ] QuickenMainWindow.TextClick(sCategory)
						[ ] ReportStatus("Verify that User is able to add a category via the right click menu." , PASS,"The category: {sCategory} has been added using right click option{sRemoveCategory} on Annual View.")
					[+] except
						[ ] ReportStatus("Verify that User is able to add a category via the right click menu." , FAIL,"The category: {sCategory} couldn't be added using right click option{sRemoveCategory} on Annual View.")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Select Categories to Budget dialog appeared. ", FAIL , "Select Categories to Budget dialog didn't appearon Annual View.") 
			[+] else
				[ ] ReportStatus("Verify Choose categories option using right click on Annual View selected." , FAIL, "Choose categories option using right click on Annual View couldn't be selected.")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
	[ ] 
[ ] // 
[+] //##########Test 59: Budget view should not change when roll over options are changed constantly. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test59_VerifyBudgetViewShouldNotChangeWhenRollOverOptionChangedConstantly
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that Budget view should not change when roll over options are changed constantly
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Budget view doesn't change when roll over options are changed constantly
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  July 10 2014
	[ ] // ********************************************************
[ ] 
[+] testcase Test59_VerifyBudgetViewShouldNotChangeWhenRollOverOptionChangedConstantly() appstate none
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] STRING sActualView , sActualSubView, sExpectedSubView
		[ ] bMatch=FALSE
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] lsCategoryList = lsExcelData[1]
		[ ] sCategoryType =trim(lsCategoryList[1])
		[ ] sCategory=trim(lsCategoryList[3])
		[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
		[+] if (iResult==PASS)
			[ ] sleep(2)
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] ////Select Annual View of budget
			[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sAnnualView)
			[ ] sleep(2)
			[ ] sExpectedSubView = MDIClient.Budget.AnnualViewTypeComboBox.GetSelectedItem() 
			[ ] //select second rollover option
			[ ] SelectDeselectRollOverOptions(sCategory , sSetRollOverBalance , FALSE)
			[ ] sleep(2)
			[ ] //Get currently selected view
			[ ] sActualView = MDIClient.Budget.BudgetViewTypeComboBox.GetSelectedItem() 
			[ ] sActualSubView = MDIClient.Budget.AnnualViewTypeComboBox.GetSelectedItem() 
			[ ] 
			[+] if ((sActualView == sAnnualView) && (sActualSubView == sExpectedSubView ))
				[ ] ReportStatus("Verify Budget view should not change when roll over options are changed constantly. ", PASS , "Budget view stayed on {sAnnualView} after selecting rollover option: {sSetRollOverBalance}.") 
			[+] else
				[ ] ReportStatus("Verify Budget view should not change when roll over options are changed constantly. ", FAIL , "Budget view didn't stayed on {sAnnualView} ,{sExpectedSubView} after selecting rollover option: {sSetRollOverBalance} the view switched to: {sActualView} , {sActualSubView}.") 
			[ ] 
			[ ] //select third rollover option
			[ ] SelectDeselectRollOverOptions(sCategory , sSetPositiveRollOverBalance , FALSE)
			[ ] sleep(2)
			[ ] //Get currently selected view
			[ ] sActualView = MDIClient.Budget.BudgetViewTypeComboBox.GetSelectedItem() 
			[ ] sActualSubView = MDIClient.Budget.AnnualViewTypeComboBox.GetSelectedItem() 
			[ ] 
			[+] if ((sActualView == sAnnualView) && (sActualSubView == sExpectedSubView ))
				[ ] ReportStatus("Verify Budget view should not change when roll over options are changed constantly. ", PASS , "Budget view stayed on {sAnnualView} after selecting rollover option: {sSetPositiveRollOverBalance}.") 
			[+] else
				[ ] ReportStatus("Verify Budget view should not change when roll over options are changed constantly. ", FAIL , "Budget view didn't stayed on {sAnnualView} ,{sExpectedSubView} after selecting rollover option: {sSetPositiveRollOverBalance} the view switched to: {sActualView} , {sActualSubView}.") 
			[ ] 
			[ ] //select first rollover option
			[ ] SelectDeselectRollOverOptions(sCategory , sSetRollOverOff , FALSE)
			[ ] sleep(2)
			[ ] //Get currently selected view
			[ ] sActualView = MDIClient.Budget.BudgetViewTypeComboBox.GetSelectedItem() 
			[ ] sActualSubView = MDIClient.Budget.AnnualViewTypeComboBox.GetSelectedItem() 
			[ ] 
			[+] if ((sActualView == sAnnualView) && (sActualSubView == sExpectedSubView ))
				[ ] ReportStatus("Verify Budget view should not change when roll over options are changed constantly. ", PASS , "Budget view stayed on {sAnnualView} after selecting rollover option: {sSetRollOverOff}.") 
			[+] else
				[ ] ReportStatus("Verify Budget view should not change when roll over options are changed constantly. ", FAIL , "Budget view didn't stayed on {sAnnualView} ,{sExpectedSubView} after selecting rollover option: {sSetRollOverOff} the view switched to: {sActualView} , {sActualSubView}.") 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
	[ ] 
[ ] 
[ ] 
[ ] 
[ ] 
[+] //##########Test 68: Budget Snapshot on Home page. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test68_VerifyBudgetDisplaysOnHomePageSnapshot
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that Budget should display on Budget Snapshot on Home page
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Budget should display on Budget Snapshot on Home page
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  July 10 2014
	[ ] // ********************************************************
[ ] 
[+] testcase Test68_VerifyBudgetDisplaysOnHomePageSnapshot() appstate none
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] bMatch=FALSE
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] sAccountName=lsAddAccount[2]
		[ ] 
		[ ] lsTxnExcelData=NULL
		[ ] lsTxnExcelData=ReadExcelTable(sBudgetExcelsheet, sRegTransactionSheet)
		[ ] lsTransaction=lsTxnExcelData[1]
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] iTotalSpending=0
		[ ] lsCategoryList = lsExcelData[1]
		[ ] sCategoryType =trim(lsCategoryList[1])
		[ ] sParentCategory=trim(lsCategoryList[2])
		[ ] ///delete category type and parent categories
		[ ] ListDelete(lsCategoryList ,1)
		[ ] ListDelete(lsCategoryList ,1)
		[+] for( iCounter=1; iCounter <=ListCount (lsCategoryList) ; iCounter++)
			[+] if (lsCategoryList[iCounter]==NULL)
				[ ] ListDelete (lsCategoryList ,iCounter)
				[ ] iCounter--
				[ ] 
		[ ] 
		[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
		[+] if (iResult==PASS)
			[ ] sleep(2)
			[ ] QuickenWindow.SetActive()
			[ ] //Calculate monthly spending
			[+] for (iCounter=1 ; iCounter<=3; iCounter++)
				[ ] lsTransaction=lsTxnExcelData[iCounter]
				[+] if(lsTransaction[1]==NULL)
					[ ] break
				[ ] ///Calculate total monthly spending
				[ ] iTxnAmount=VAL(lsTransaction[3])
				[ ] iTotalSpending =iTxnAmount+iTotalSpending
				[ ] 
			[ ] 
			[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
			[+] if (iResult==PASS)
				[ ] sleep(2)
				[ ] iResult=DeleteBudget()
				[+] if (iResult==PASS)
					[ ] iResult=AddBudget(sBudgetName)
					[+] if (iResult==PASS)
						[ ] ReportStatus("Verify budget gets added.", PASS, "Budget: {sBudgetName} has been added.")
						[ ] 
						[ ] QuickenWindow.SetActive()
						[ ] 
						[ ] 
						[ ] //// Set Parent rollup on
						[ ] SelectBudgetOptionOnGraphAnnualView(sGraphView,"Rollup")
						[ ] sleep(2)
						[ ] 
						[ ] 
						[ ] ////Verify summary bar on Graph View
						[ ] QuickenWindow.SetActive()
						[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sGraphView)
						[ ] sleep(2)
						[ ] ///Verify Graph View Summary> Total Spending
						[ ] sActualSummaryTotalSpending = MDIClient.Budget.GraphViewSummaryTotalSpending.GetProperty("Caption")
						[ ] sActualSummaryTotalSpending=StrTran( sActualSummaryTotalSpending,"$","")
						[ ] sActualSummaryTotalSpending=StrTran( sActualSummaryTotalSpending,",","")
						[ ] 
						[ ] bMatch = MatchStr("*{str(iTotalSpending)}*" , sActualSummaryTotalSpending)
						[+] if (bMatch)
							[ ] ReportStatus("Verify that Summary bar on Graph View" , PASS , "Summary bar spending: {sActualSummaryTotalSpending} is as expected: {iTotalSpending} on Graph View.")
							[ ] 
							[ ] iResult=NavigateQuickenTab(sTAB_HOME)
							[+] if (iResult==PASS)
								[ ] sleep(2)
								[ ] 
								[ ] MDIClient.Home.VScrollBar.ScrollToMax()
								[ ] sActualSummaryTotalSpending = MDIClient.Home.GraphViewSummaryTotalSpending.GetProperty("Caption")
								[ ] bMatch = MatchStr("*{str(iTotalSpending)}*" , sActualSummaryTotalSpending)
								[+] if (bMatch)
									[ ] ReportStatus("Verify Summary bar on Home tab > Budget Snapshot" , PASS , "Summary bar spending: {sActualSummaryTotalSpending} is as expected: {iTotalSpending} on Home tab > Budget Snapshot.")
									[ ] 
									[ ] ///Add all the budgeted categories to budget on Home page snapshot
									[ ] MDIClient.Home.TextClick("Options", 1)
									[ ] sleep(1)
									[ ] QuickenWindow.TypeKeys(KEY_DN)
									[ ] sleep(1)
									[ ] QuickenWindow.TypeKeys(KEY_ENTER)
									[+] if (SelectCategoriesToBudget.Exists(4))
										[ ] SelectCategoriesToBudget.SetActive()
										[ ] SelectCategoriesToBudget.TextClick(sCategoryType)
										[ ] sHandle= Str(SelectCategoriesToBudget.ListBox.GetHandle())
										[ ] iListCount= SelectCategoriesToBudget.ListBox.GetItemCount() 
										[ ] 
										[+] for(iCounter= 1; iCounter <= ListCount(lsCategoryList);  iCounter++)
											[ ] sCategory=lsCategoryList[iCounter]
											[ ] 
											[+] do
												[ ] SelectCategoriesToBudget.TextClick(sCategory)
												[ ] ReportStatus("Verify Category found in the Select Categories To Budget dialog.", FAIL, "Category:{sCategory} couldn't be found in the Select Categories To Budget dialog on Homepage snapshot.")
											[+] except
												[ ] ReportStatus("Verify Category found in the Select Categories To Budget dialog.", FAIL, "Category:{sCategory} couldn't be found in the Select Categories To Budget dialog on Homepage snapshot.")
										[ ] 
										[ ] SelectCategoriesToBudget.OK.Click()
										[ ] WaitForState(SelectCategoriesToBudget , False ,3)
										[ ] ////Verify categories added on the budget snapshot
										[ ] sHandle= Str(MDIClient.Home.ListBox2.GetHandle())
										[ ] iListCount= MDIClient.Home.ListBox2.GetItemCount() 
										[ ] 
										[ ] ///Verify the category group on homepage 
										[ ] 
										[+] for (iCount=0 ; iCount<=iListCount; iCount++)
											[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
											[ ] bMatch= MatchStr("*{sCategoryType}*" ,sActual)
											[+] if (bMatch)
												[ ] break
										[+] if (bMatch)
											[ ] ReportStatus("Verfiy budget category added to budget on Homepage snapshot." ,PASS,"Budget category type: {sCategoryType} added to budget on Homepage snapshot.")
										[+] else
											[ ] ReportStatus("Verfiy budget category added to budget on Homepage snapshot." ,FAIL,"Budget category type: {sCategoryType} couldn't be added to budget on Homepage snapshot.")
										[ ] 
										[+] for (iCounter=1 ; iCounter<=3; iCounter++)
											[ ] lsTransaction=lsTxnExcelData[iCounter]
											[+] if(lsTransaction[1]==NULL)
												[ ] break
											[ ] ///Calculate total monthly spending
											[ ] iTxnAmount=VAL(lsTransaction[3])
											[ ] sCategory=trim(lsTransaction[8])
											[ ] 
											[+] for (iCount=0 ; iCount<=iListCount; iCount++)
												[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
												[ ] sExpectedCategory=NULL
												[ ] sExpectedCategory= sParentCategory+": "+sCategory
												[ ] bMatch= MatchStr("*{sExpectedCategory}*{iTxnAmount}*" ,sActual)
												[+] if (bMatch)
													[ ] break
											[+] if (bMatch)
												[ ] ReportStatus("Verfiy budget category added to budget on Homepage snapshot." ,PASS,"Budget category: {sExpectedCategory} added to budget on Homepage snapshot.")
											[+] else
												[ ] ReportStatus("Verfiy budget category added to budget on Homepage snapshot." ,FAIL,"Budget category: {sExpectedCategory} couldn't be added to budget on Homepage snapshot.")
										[ ] 
										[ ] ///Add a transaction to for one category 
										[ ] iResult= SelectAccountFromAccountBar(sAccountName, ACCOUNT_BANKING)
										[+] if (iResult==PASS)
											[ ] 
											[ ] sPayee="NewTxn"
											[ ] AddCheckingTransaction(lsTransaction[1],lsTransaction[2],lsTransaction[3],sDate,lsTransaction[5],sPayee,lsTransaction[7],lsTransaction[8])
											[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_HOME)
											[+] if (iResult==PASS)
												[ ] MDIClient.Home.VScrollBar.ScrollToMax()
												[ ] //Now as the transaction amount for the category should be doubled
												[+] if (MDIClient.Home.ViewupdatesButton.IsEnabled())
													[ ] MDIClient.Home.ViewupdatesButton.Click()
													[ ] sleep(1)
													[ ] ReportStatus("Verify that Veiw Updates button enabled on Budget view of Home Page snapshot." , PASS, "Veiw Updates button enabled on Budget view of Home Page snapshot after adding a new transaction.")
													[ ] iTxnAmount =VAL(lsTransaction[3])
													[ ] iTxnAmount=iTxnAmount*2
													[ ] sHandle= Str(MDIClient.Home.ListBox2.GetHandle())
													[ ] iListCount= MDIClient.Home.ListBox2.GetItemCount() 
													[+] for (iCount=0 ; iCount<=iListCount; iCount++)
														[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
														[ ] sExpectedCategory=NULL
														[ ] sExpectedCategory= sParentCategory+": "+sCategory
														[ ] bMatch= MatchStr("*{sExpectedCategory}*{iTxnAmount}*" ,sActual)
														[+] if (bMatch)
															[ ] break
													[+] if (bMatch)
														[ ] ReportStatus("Verfiy category amount updated after clicking Veiw updates button on budget on Homepage snapshot." ,PASS,"Budget category: {sExpectedCategory} updated with amount:{iTxnAmount} after clicking Veiw updates button on budget on Homepage snapshot.")
													[+] else
														[ ] ReportStatus("Verfiy category amount updated after clicking Veiw updates button on budget on Homepage snapshot." ,FAIL,"Budget category: {sExpectedCategory} didn't update with amount:{iTxnAmount} after clicking Veiw updates button on budget on Homepage snapshot.")
													[ ] 
													[ ] 
													[ ] //Delete the extra transaction
													[ ] iResult= SelectAccountFromAccountBar(sAccountName, ACCOUNT_BANKING)
													[+] if (iResult==PASS)
														[ ] sleep(2)
														[ ] DeleteTransaction("MDI" ,sPayee)
													[+] else
														[ ] ReportStatus("Verfiy account: {sAccountName} selected." , FAIL ,"Account: {sAccountName} coulkdn't be selected.")
													[ ] 
													[ ] 
												[+] else
													[ ] ReportStatus("Verify that Veiw Updates button enabled on Budget view of Home Page snapshot." , FAIL, "Veiw Updates button didn't enable on Budget view of Home Page snapshot after adding a new transaction.")
												[ ] 
											[+] else
												[ ] ReportStatus("Verify Quicken navigated to {sTAB_HOME}. ", FAIL , "Quicken didn't navigate to {sTAB_HOME}.") 
										[+] else
											[ ] ReportStatus("Verfiy account: {sAccountName} selected." , FAIL ,"Account: {sAccountName} coulkdn't be selected.")
										[ ] 
									[+] else
										[ ] ReportStatus("Verify Select Categories to Budget dialog appeared. ", FAIL , "Select Categories to Budget dialog didn't appear.") 
									[ ] 
								[+] else
									[ ] ReportStatus("Verify Summary bar on Home tab > Budget Snapshot" , FAIL , "Summary bar spending: {sActualSummaryTotalSpending} is as NOT as expected: {iTotalSpending} on Home tab > Budget Snapshot.")
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Quicken navigated to {sTAB_HOME}. ", FAIL , "Quicken didn't navigate to {sTAB_HOME}.") 
						[+] else
							[ ] ReportStatus("Verify that Summary bar on Graph View." , FAIL , "Summary bar spending: {sActualSummaryTotalSpending} is NOT as expected: {iTotalSpending} on Graph View.")
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify budget gets added.", FAIL, "Budget: {sBudgetName} couldn't be added.")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify budget gets deleted.", FAIL, "Budget: {sBudgetName} couldn't be deleted.")
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
	[ ] 
[ ] 
[ ] 
[ ] 
[+] //##########Test 69: Verify budget amount updates for Snapshot on Home page. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test69_VerifyBudgetGetsUpdatedOnHomePageSnapshot
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that Budget amount gets updated on Budget Snapshot on Home page
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If  Budget amount gets updated on Budget Snapshot on Home page
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  July 10 2014
	[ ] // ********************************************************
[ ] 
[+] testcase Test69_VerifyBudgetGetsUpdatedOnHomePageSnapshot() appstate none
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] bMatch=FALSE
		[ ] 
		[ ] iBudgetAmount=100
		[ ] lsTxnExcelData=NULL
		[ ] lsTxnExcelData=ReadExcelTable(sBudgetExcelsheet, sRegTransactionSheet)
		[ ] lsTransaction=lsTxnExcelData[1]
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] iTotalSpending=0
		[ ] lsCategoryList = lsExcelData[1]
		[ ] sCategoryType =trim(lsCategoryList[1])
		[ ] sParentCategory=trim(lsCategoryList[2])
		[ ] ///delete category type and parent categories
		[ ] ListDelete(lsCategoryList ,1)
		[ ] ListDelete(lsCategoryList ,1)
		[+] for( iCounter=1; iCounter <=ListCount (lsCategoryList) ; iCounter++)
			[+] if (lsCategoryList[iCounter]==NULL)
				[ ] ListDelete (lsCategoryList ,iCounter)
				[ ] iCounter--
				[ ] 
		[ ] 
		[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
		[+] if (iResult==PASS)
			[ ] sleep(2)
			[ ] QuickenWindow.SetActive()
			[ ] //Calculate monthly spending
			[+] // for (iCounter=1 ; iCounter<=3; iCounter++)
				[ ] // lsTransaction=lsTxnExcelData[iCounter]
				[+] // if(lsTransaction[1]==NULL)
					[ ] // break
				[ ] // ///Calculate total monthly spending
				[ ] // iTxnAmount=VAL(lsTransaction[3])
				[ ] // iTotalSpending =iTxnAmount+iTotalSpending
				[ ] // 
			[ ] 
			[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
			[+] if (iResult==PASS)
				[ ] sleep(2)
				[ ] 
				[ ] ///Remove the first category in the list
				[ ] sCategory=trim(lsCategoryList[1])
				[ ] RemoveCategoryFromBudget(sCategory)
				[ ] 
				[ ] //Update budget for the second category
				[ ] sCategory=NULL
				[ ] sCategory=trim(lsCategoryList[2])
				[ ] MDIClient.Budget.ListBox.TextClick(sCategory)
				[ ] MDIClient.Budget.ListBox.Amount.SetText(Str(iBudgetAmount))
				[ ] 
				[ ] iResult=NavigateQuickenTab(sTAB_HOME)
				[+] if (iResult==PASS)
					[ ] sleep(2)
					[ ] ////Verify categories added on the budget snapshot on Home
					[ ] sHandle= Str(MDIClient.Home.ListBox2.GetHandle())
					[ ] iListCount= MDIClient.Home.ListBox2.GetItemCount() 
					[ ] 
					[ ] ///Verify that first category removed from the budget snapshot on Home
					[ ] sCategory=trim(lsCategoryList[1])
					[+] for (iCount=0 ; iCount<=iListCount; iCount++)
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
						[ ] bMatch= MatchStr("*{sCategory}*" ,sActual)
						[+] if (bMatch)
							[ ] break
					[+] if (bMatch==FALSE)
						[ ] ReportStatus("Verfiy budget category removed from budget on Homepage snapshot." ,PASS,"Budget category type: {sCategory} removed from budget on Homepage snapshot when removed from the budegt itself.")
					[+] else
						[ ] ReportStatus("Verfiy budget category removed from budget on Homepage snapshot." ,FAIL,"Budget category type: {sCategory} couldn't be removed to budget on Homepage snapshot when removed from the budegt itself.")
					[ ] 
					[ ] ///Verify that second category's budget updated on budget snapshot on Home
					[ ] sCategory=trim(lsCategoryList[2])
					[+] for (iCount=0 ; iCount<=iListCount; iCount++)
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
						[ ] bMatch= MatchStr("*{sCategory}*{iBudgetAmount}*" ,sActual)
						[+] if (bMatch)
							[ ] break
					[+] if (bMatch)
						[ ] ReportStatus("Verify that second category's budget updated on budget snapshot on Home." ,PASS,"Budget amount for category: {sCategory} updated as expected amount:{iBudgetAmount} at budget on Homepage snapshot when updated from the budegt itself.")
					[+] else
						[ ] ReportStatus("Verify that second category's budget updated on budget snapshot on Home." ,FAIL, "Budget amount for category: {sCategory} didn't update as expected amount:{iBudgetAmount} at budget on Homepage snapshot when updated from the budegt itself.")
				[+] else
					[ ] ReportStatus("Verify Quicken navigated to {sTAB_HOME}. ", FAIL , "Quicken didn't navigate to {sTAB_HOME}.") 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
	[ ] 
[ ] 
[ ] 
[+] //##########Test 70: Verify that negative values can be entered in Budget from Annual budget view for a expense category. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test70_VerifyEnteringNegativeBudgetForExpenseCategoryOnAnnualView
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that negative values can be entered in Budget from Annual budget view for a expense category
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If negative values can be entered in Budget from Annual budget view for a expense category
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  July 14 2014
	[ ] // ********************************************************
[ ] 
[+] testcase Test70_VerifyEnteringNegativeBudgetForExpenseCategoryOnAnnualView() appstate none
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] INTEGER iActual
		[ ] bMatch=FALSE
		[ ] 
		[ ] iBudgetAmount=-50
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] iTotalSpending=0
		[ ] lsCategoryList = lsExcelData[1]
		[ ] sCategoryType =trim(lsCategoryList[1])
		[ ] sParentCategory=trim(lsCategoryList[2])
		[ ] ///delete category type and parent categories
		[ ] ListDelete(lsCategoryList ,1)
		[ ] ListDelete(lsCategoryList ,1)
		[+] for( iCounter=1; iCounter <=ListCount (lsCategoryList) ; iCounter++)
			[+] if (lsCategoryList[iCounter]==NULL)
				[ ] ListDelete (lsCategoryList ,iCounter)
				[ ] iCounter--
				[ ] 
		[ ] 
		[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
		[+] if (iResult==PASS)
			[ ] sleep(2)
			[ ] QuickenWindow.SetActive()
			[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
			[+] if (iResult==PASS)
				[ ] sleep(2)
				[ ] iResult=DeleteBudget()
				[+] if (iResult==PASS)
					[ ] iResult=AddBudget(sBudgetName)
					[+] if (iResult==PASS)
						[ ] 
						[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sAnnualView)
						[ ] sleep(2)
						[ ] //Update budget for the first expense category in the list with negative budget
						[ ] sCategory=NULL
						[ ] sCategory=trim(lsCategoryList[1])
						[ ] MDIClient.Budget.ListBox.TextClick(sCategory)
						[ ] sleep(1)
						[ ] MDIClient.Budget.ListBox.Amount.SetText(Str(iBudgetAmount))
						[ ] 
						[ ] ///Select some other category
						[ ] MDIClient.Budget.ListBox.TextClick(trim(lsCategoryList[2]))
						[ ] 
						[ ] //Again select the same category and verify the budget amount for this category
						[ ] MDIClient.Budget.ListBox.TextClick(sCategory)
						[ ] sleep(0.5)
						[ ] sActual=MDIClient.Budget.ListBox.Amount.GetText()
						[ ] iActual=VAL(sActual)
						[ ] 
						[+] if (iActual==iBudgetAmount)
							[ ] ReportStatus("Verify that negative budget can be entered for expense category." , PASS, "The negative budget:{iBudgetAmount} has been entered for expense category: {sCategory} on Annual View.")
						[+] else
							[ ] ReportStatus("Verify that negative budget can be entered for expense category." , FAIL, "The expected budget amount:{iBudgetAmount} is not as actual: {iActual} for expense category: {sCategory} on Annual View.")
						[ ] 
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify budget gets added.", FAIL, "Budget: {sBudgetName} couldn't be added.")
				[+] else
					[ ] ReportStatus("Verify budget gets deleted.", FAIL, "Budget: {sBudgetName} couldn't be deleted.")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
	[ ] 
[ ] 
[ ] 
[+] //##########Test 71: Verify that negative values can be entered in Budget from Annual budget view for a income category. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test71_VerifyEnteringNegativeBudgetForIncomeCategoryOnAnnualView
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that negative values can be entered in Budget from Annual budget view for a income category
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If negative values can be entered in Budget from Annual budget view for a income category
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  July 15 2014
	[ ] // ********************************************************
[ ] 
[+] testcase Test71_VerifyEnteringNegativeBudgetForIncomeCategoryOnAnnualView() appstate none
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] INTEGER iActual
		[ ] bMatch=FALSE
		[ ] 
		[ ] iBudgetAmount=-50
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] iTotalSpending=0
		[ ] lsCategoryList = lsExcelData[3]
		[ ] sCategoryType =trim(lsCategoryList[1])
		[ ] sCategory=trim(lsCategoryList[2])
		[ ] 
		[+] for( iCounter=1; iCounter <=ListCount (lsCategoryList) ; iCounter++)
			[+] if (lsCategoryList[iCounter]==NULL)
				[ ] ListDelete (lsCategoryList ,iCounter)
				[ ] iCounter--
				[ ] 
		[ ] 
		[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
		[+] if (iResult==PASS)
			[ ] 
			[ ] iResult=SelectOneCategoryToBudget(sCategoryType ,sCategory)
			[+] if (iResult==PASS)
				[ ] 
				[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sAnnualView)
				[ ] sleep(2)
				[ ] //Update budget for the income category with negative budget
				[ ] MDIClient.Budget.ListBox.TextClick(sCategory)
				[ ] sleep(1)
				[ ] MDIClient.Budget.ListBox.Amount.SetText(Str(iBudgetAmount))
				[ ] 
				[ ] //Again select the same category and verify the budget amount for this category
				[ ] MDIClient.Budget.ListBox.TextClick(sCategory)
				[ ] sleep(0.5)
				[ ] sActual=MDIClient.Budget.ListBox.Amount.GetText()
				[ ] iActual=VAL(sActual)
				[ ] 
				[+] if (iActual==iBudgetAmount)
					[ ] ReportStatus("Verify that negative budget can be entered for income category." , PASS, "The negative budget:{iBudgetAmount} has been entered for income category: {sCategory} on Annual View.")
				[+] else
					[ ] ReportStatus("Verify that negative budget can be entered for income category." , FAIL, "The expected budget amount:{iBudgetAmount} is not as actual: {iActual} for income category: {sCategory} on Annual View.")
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify category added to the budget.", FAIL , "Category: {sParentCategory} of type: {sCategoryType} couldn't be added to the budget.") 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
	[ ] 
[ ] 
[+] //##########Test 72: Verify that negative value entered for any category in Annual Budget view is not shown as Positive in Graph budget view and in Budget report. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test72_VerifyNegativeBudgetForCategoryOnAnnualViewDoesNotAppearAsPostiveOnReportsGraphView
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that negative value entered for any category in Annual Budget view is not shown as Positive in Graph budget view and in Budget report
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If egative value entered for any category in Annual Budget view is not shown as Positive in Graph budget view and in Budget report
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  July 15 2014
	[ ] // ********************************************************
[ ] 
[+] testcase Test72_VerifyNegativeAverageBudgetForCategoryOnAnnualViewIsNotPostiveOnReportsGraphView() appstate none
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] INTEGER iActual
		[ ] bMatch=FALSE
		[ ] 
		[ ] iBudgetAmount=-50
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] iTotalSpending=0
		[ ] lsCategoryList = lsExcelData[1]
		[ ] sCategoryType =trim(lsCategoryList[1])
		[ ] sParentCategory=trim(lsCategoryList[2])
		[ ] 
		[ ] sCategory=trim(lsCategoryList[3])
		[ ] 
		[ ] 
		[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
		[+] if (iResult==PASS)
			[ ] 
			[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sAnnualView)
			[ ] sleep(2)
			[ ] iResult=AddAverageBudget(sCategory ,iBudgetAmount)
			[+] if (iResult==PASS)
				[ ] ReportStatus("Verify that User is able to add average budget for category: {sCategory} with amount: {iBudgetAmount}."  , PASS,"Average budget for category: {sCategory} with amount: {iBudgetAmount} has been added on Annual View.")
				[ ] ///Verfiy negative average budget on annual view
				[ ] ///Create the expected budget amounts
				[ ] sExpectedAmount="*{iBudgetAmount}*"
				[+] for (iCount=1 ; iCount<=11;++iCount)
					[ ] sExpectedAmount=sExpectedAmount+"*{iBudgetAmount}*"
				[ ] 
				[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
				[ ] iListCount= MDIClient.Budget.ListBox.GetItemCount() +1
				[ ] 
				[ ] ///Verify on annual view
				[+] for (iCount=2 ; iCount<=iListCount;++iCount)
					[ ] 
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
					[ ] bMatch = MatchStr("*{sExpectedAmount}*", sActual)
					[+] if (bMatch)
						[ ] break
				[+] if(bMatch)
					[ ] ReportStatus("Verfiy negative average budget on annual view." ,PASS, "The Average budget for 12 months:has been updated:{sActual} as expected:{sExpectedAmount} for category: {sCategory} on Annual View.")
				[+] else
					[ ] ReportStatus("Verfiy negative average budget on annual view." ,FAIL, "The Average budget for 12 months couldn't be updated actualt: {sActual} as expected:{sExpectedAmount} for category: {sCategory} on Annual View.")
				[ ] 
				[ ] 
				[ ] ///Verfiy the negative budget on Graph view
				[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sGraphView)
				[ ] sleep(2)
				[ ] QuickenWindow.SetActive()
				[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
				[ ] iListCount= MDIClient.Budget.ListBox.GetItemCount() +1
				[ ] 
				[+] for (iCount=0 ; iCount<=iListCount;++iCount)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
					[ ] bMatch = MatchStr("*{sCategory}*{iBudgetAmount}*", sActual)
					[+] if (bMatch)
						[ ] break
				[+] if(bMatch)
					[ ] ReportStatus("Verfiy negative average budget on graph view added on annual view." ,PASS, "The Average negative budget added on annual view actual is :{sActual} as expected:{iBudgetAmount} for category: {sCategory} on Graph View.")
				[+] else
					[ ] ReportStatus("Verfiy negative average budget on graph view added on annual view." ,FAIL, "The Average negative budget added on annual view actual is :{sActual} NOT as expected:{iBudgetAmount} for category: {sCategory} on Graph View.")
				[ ] 
				[ ] ///Verfiy the negative budget on Historical Budget report
				[ ] iTotalBudget=iBudgetAmount*12
				[ ] 
				[ ] SelectBudgetReportOnGraphView(sREPORT_HISTORICAL_BUDGET)
				[+] if (HistoricalBudget.Exists(2))
					[ ] HistoricalBudget.SetActive()
					[ ] sleep(1)
					[ ] HistoricalBudget.Maximize()
					[ ] sleep(2)
					[ ] sHandle= Str(HistoricalBudget.ListBox.GetHandle())
					[ ] iListCount =HistoricalBudget.ListBox.GetItemCount() 
					[+] for(iCount= 1; iCount <= iListCount;  iCount++)
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
						[+] if (sActual!=NULL)
							[ ] ListAppend(lsActualData ,sActual)
						[ ] bMatch = MatchStr("*{sCategory}*{iTotalBudget}*", sActual)
						[+] if (bMatch)
							[ ] break
					[+] if (bMatch)
						[ ] ReportStatus("Verfiy negative average budget on report: {sREPORT_HISTORICAL_BUDGET }added on annual view." ,PASS, "The Average negative budget added on annual view actual is :{sActual} as expected:{iTotalBudget} for category: {sCategory} on report: {sREPORT_HISTORICAL_BUDGET}.")
					[+] else
						[ ] ReportStatus("Verfiy negative average budget on report: {sREPORT_HISTORICAL_BUDGET }added on annual view." ,FAIL, "The Average negative budget added on annual view actual is :{lsActualData}  NOT as expected:{iTotalBudget} for category: {sCategory} on report: {sREPORT_HISTORICAL_BUDGET}.")
					[ ] 
					[ ] 
					[ ] HistoricalBudget.SetActive()
					[ ] HistoricalBudget.Close()
					[ ] WaitForState(HistoricalBudget , False ,2)
				[+] else
					[ ] ReportStatus("Verify report: {sREPORT_CURRENT_BUDGET} on budget Graph View.", FAIL , " {sREPORT_CURRENT_BUDGET} on budget Graph View didn't appear.") 
					[ ] 
					[ ] 
					[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify that User is able to add average budget for category: {sCategory} with amount: {iBudgetAmount}."  , FAIL,"Average budget for category: {sCategory} with amount: {iBudgetAmount} couldn't be added on Annual View.")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
	[ ] 
[ ] 
[ ] 
[ ] 
[+] //##########Test 157: Verify 'Create new Budget' option from 'Budget Actions' menu.. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test157_VerifyCreateNewBudgetUsingAccountActions
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify 'Create new Budget' option from 'Budget Actions' menu
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Budget gets created for differnent calander
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  July 16  2014
		[ ] //
	[ ] // ********************************************************
[ ] 
[+] testcase Test157_VerifyCreateNewBudgetUsingAccountActions() appstate none
	[+] //--------------Variable Declaration-------------
		[ ] INTEGER iFutureYear ,iCurrentYear
		[ ] sBudgetName="TestNewBudget"
		[ ] 
		[ ] sCurrentMonth = FormatDateTime(GetDateTime(),"mm")
		[ ] iCurrentMonth= VAL(sCurrentMonth)
		[ ] 
		[ ] sCurrentYear=FormatDateTime(GetDateTime(),"yyyy")
		[ ] iCurrentYear=VAL(sCurrentYear)
		[ ] iFutureYear=iCurrentYear+1
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
		[+] if (iResult==PASS)
			[ ] sleep(2)
			[ ] 
			[ ] MDIClient.Budget.BudgetActions.Click()
			[ ] MDIClient.Budget.BudgetActions.TypeKeys(Replicate(KEY_DN, 7))
			[ ] MDIClient.Budget.BudgetActions.TypeKeys(KEY_ENTER)
			[ ] 
			[ ] 
			[+] if (CreateANewBudget.Exists(5))
				[ ] CreateANewBudget.SetActive()
				[ ] CreateANewBudget.BudgetName.SetText(sBudgetName)
				[ ] CreateANewBudget.AdvanceBudgetSettingsButton.Click()
				[ ] CreateANewBudget.UseDifferentCalendarRadioList.Select(2)
				[ ] CreateANewBudget.CalendarComboBox.Select(iCurrentMonth+1)
				[ ] CreateANewBudget.OK.Click()
				[ ] WaitForState(QuickenWindow,TRUE,2)
				[ ] QuickenWindow.SetActive()
				[ ] 
				[ ] ////Verify new budget created
				[+] if (MDIClient.Budget.BudgetNameComboBox.GetSelectedItem()==sBudgetName)
					[ ] ReportStatus("Verify budget gets created using 'Create new Budget' option from 'Budget Actions' menu", PASS, "Budget gets created using 'Create new Budget' option from 'Budget Actions' menu.")
					[ ] 
					[ ] MDIClient.Budget.ForwardMonthButton.Click()
					[+] if (DlgAddABudgetForNextOrPreviousYear.Exists(2))
						[ ] DlgAddABudgetForNextOrPreviousYear.SetActive()
						[ ] sActual=DlgAddABudgetForNextOrPreviousYear.GetProperty("Caption")
						[ ] bMatch = MatchStr("*{iFutureYear}*", sActual)
						[+] if (bMatch)
							[ ] ReportStatus("Verify creating a budget for different calendar using 'Create new Budget' option from 'Budget Actions' menu" , PASS , "Budget for different calendar has been created successfully.")
						[+] else
							[ ] ReportStatus("Verify creating a budget for different calendar using 'Create new Budget' option from 'Budget Actions' menu" , FAIL , "Budget for different calendar couldn't be created successfully.")
						[ ] 
						[ ] DlgAddABudgetForNextOrPreviousYear.CancelButton.Click()
					[+] else
						[ ] ReportStatus("Verify the Budget can be extended to next year." , FAIL, "Dialog:{sActual} didn't appear.")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify budget gets created using 'Create new Budget' option from 'Budget Actions' menu", FAIL, "Budget couldn't be created using 'Create new Budget' option from 'Budget Actions' menu.")
			[+] else
				[ ] ReportStatus("Verify Create A New Budget dialog", FAIL, "Create A New Budget dialog didn't appear .")
				[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
[ ] 
[+] //##########Test 159: Verify 'Edit budget name -> View Options -> Edit budget name' option from 'Budget Actions' menu. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test159_VerifyEditBudgetNameUsingAccountActions
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify View Options -> Edit budget name' option from 'Budget Actions' menu
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Budget name gets edited
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  July 16  2014
		[ ] //
	[ ] // ********************************************************
[ ] 
[+] testcase Test159_VerifyEditBudgetNameUsingAccountActions() appstate none
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] sBudgetName="TestNewBudget"
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
		[+] if (iResult==PASS)
			[ ] sleep(2)
			[ ] MDIClient.Budget.BudgetNameComboBox.Select(sBudgetName)
			[ ] 
			[ ] 
			[ ] SelectBudgetOptionOnGraphAnnualView(sGraphView , "Edit budget name")
			[ ] ///edit budget name
			[ ] sBudgetName="EditedBudgetName"
			[+] if (DlgEditBudgetName.Exists(5))
				[ ] DlgEditBudgetName.SetActive()
				[ ] DlgEditBudgetName.EditBudgetNameTextField.SetText(sBudgetName)
				[ ] DlgEditBudgetName.OKButton.Click()
				[ ] WaitForState(QuickenWindow,TRUE,2)
				[ ] QuickenWindow.SetActive()
				[+] if (MDIClient.Budget.BudgetNameComboBox.GetSelectedItem()==sBudgetName)
					[ ] ReportStatus("Verify budget gets renamed using 'Edit budget name' option from 'Budget Actions' menu", PASS, "Budget got  renamed using 'Edit budget name' option from 'Budget Actions' menu.")
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify budget gets renamed using 'Edit budget name' option from 'Budget Actions' menu", FAIL, "Budget didn't get renamed using 'Edit budget name' option from 'Budget Actions' menu.")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Edit Budget Name dialog", FAIL, "Edit Budget Name dialog didn't appear .")
				[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
[ ] 
[ ] 
[+] //##########Test 158: Verify 'Delete this budget' option from 'Budget Actions' menu. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test158_VerifyDeleteThisBudgetUsingAccountActions
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify 'Delete this budget' option from 'Budget Actions' menu
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Budget name gets deleted
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  July 16  2014
		[ ] //
	[ ] // ********************************************************
[ ] 
[+] testcase Test158_VerifyDeleteThisBudgetUsingAccountActions() appstate none
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] sBudgetName="EditedBudgetName"
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
		[+] if (iResult==PASS)
			[ ] sleep(2)
			[ ] MDIClient.Budget.BudgetNameComboBox.Select(sBudgetName)
			[ ] 
			[ ] 
			[ ] ///Delete budget using budget actions
			[ ] 
			[ ] MDIClient.Budget.BudgetActions.Click()
			[ ] MDIClient.Budget.BudgetActions.TypeKeys(Replicate(KEY_DN, 6))
			[ ] MDIClient.Budget.BudgetActions.TypeKeys(KEY_ENTER)
			[ ] sleep(SHORT_SLEEP)
			[+] if(DeleteBudget.DeleteButton.Exists(5))
				[ ] DeleteBudget.SetActive()
				[ ] DeleteBudget.DeleteButton.Click()
				[ ] 
				[+] if(!MDIClient.Budget.BudgetNameComboBox.Exists())
					[ ] ReportStatus("Verify 'Delete this budget' option from 'Budget Actions' menu", PASS, "Budget:{sBudgetName} has been deleted.")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify 'Delete this budget' option from 'Budget Actions' menu", FAIL, "Budget:{sBudgetName} couldn't be deleted.")
					[ ] 
			[+] else
				[ ] ReportStatus("Verify Delete Budget dialog launched using option from 'Budget Actions' menu.", FAIL, "Delete Budget dialog didn't appear using option from 'Budget Actions' menu.")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
[ ] 
[ ] 
[ ] 
[+] //##########Test 98: Verify that Category picker link opens Select Category to Budget dialog. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test98_VerifyThatCategoryPickerLinkOpensSelectCategoryToBudgetDialog
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that Category picker link opens Select Category to Budget dialog.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Category picker link opens Select Category to Budget dialog.
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  July 17  2014
		[ ] //
	[ ] // ********************************************************
[ ] 
[+] testcase Test98_VerifyThatCategoryPickerLinkOpensSelectCategoryToBudgetDialog() appstate none
	[ ] 
	[ ] //--------------Variable Declaration-------------
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
		[ ] 
		[ ] 
		[+] if (iResult==PASS)
			[ ] 
			[ ] ////Verify that Category picker link opens Select Category to Budget dialog on Graph View.
			[ ] QuickenWindow.SetActive()
			[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sGraphView)
			[ ] sleep(2)
			[ ] 
			[ ] 
			[+] if (MDIClient.Budget.SelectCategoryToBudgetLink.Exists(4))
				[ ] 
				[ ] ReportStatus("Verify Select Category To Budget Link is present on Graph View." , PASS , "Select Category To Budget Link is present on Graph View.")
				[ ] MDIClient.Budget.SelectCategoryToBudgetLink.Click()
				[+] if (SelectCategoriesToBudget.Exists(4))
					[ ] SelectCategoriesToBudget.SetActive()
					[ ] ReportStatus("Verify that Category picker link opens Select Category to Budget dialog on Graph View.", PASS , "Category picker link opened Select Category to Budget dialog on Graph View.") 
					[ ] SelectCategoriesToBudget.Cancel.Click()
					[ ] WaitForState(SelectCategoriesToBudget , False ,3)
				[+] else
					[ ] ReportStatus(" Verify that Category picker link opens Select Category to Budget dialog on Graph View.", FAIL , "Category picker link didn't open Select Category to Budget dialog on Graph View.") 
			[+] else
				[ ] ReportStatus("Verify Select Category To Budget Link is present on Graph View." , FAIL , "Select Category To Budget Link is NOT present on Graph View.")
			[ ] ////Verify that Category picker link opens Select Category to Budget dialog on Annual View.
			[ ] QuickenWindow.SetActive()
			[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sAnnualView)
			[ ] sleep(2)
			[ ] 
			[+] if (MDIClient.Budget.SelectCategoryToBudgetLink.Exists(4))
				[ ] ReportStatus("Verify Select Category To Budget Link is present on Annual View." , PASS , "Select Category To Budget Link is present on Annual View.")
				[ ] MDIClient.Budget.SelectCategoryToBudgetLink.Click()
				[+] if (SelectCategoriesToBudget.Exists(4))
					[ ] SelectCategoriesToBudget.SetActive()
					[ ] ReportStatus("Verify that Category picker link opens Select Category to Budget dialog on Annual View.", PASS , "Category picker link opened Select Category to Budget dialog on Annual View.") 
					[ ] SelectCategoriesToBudget.Cancel.Click()
					[ ] WaitForState(SelectCategoriesToBudget , False ,3)
				[+] else
					[ ] ReportStatus(" Verify that Category picker link opens Select Category to Budget dialog on Annual View.", FAIL , "Category picker link didn't open Select Category to Budget dialog on Annual View.") 
			[+] else
				[ ] ReportStatus("Verify Select Category To Budget Link is present on Annual View." , FAIL , "Select Category To Budget Link is NOT present on Annual View.")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
[ ] 
[+] //##########Test 99: Verify that selected categories from select Category to Budget dialog in Graph view gets included in Budget Graph as well as Annual view. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test99_VerifyThatCategoriesAddedFromGraphViewAreAvailableAtAnnualAndGraphView
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that selected categories from select Category to Budget dialog in Graph view gets included in Budget Graph as well as Annual view
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If selected categories from select Category to Budget dialog in Graph view gets included in Budget Graph as well as Annual viewt
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  July 18  2014
		[ ] //
	[ ] // ********************************************************
[ ] 
[+] testcase Test99_VerifyThatCategoriesAddedFromGraphViewAreAvailableAtAnnualAndGraphView() appstate none
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] lsCategoryList = lsExcelData[3]
		[ ] sCategoryType =trim(lsCategoryList[1])
		[ ] sCategory=trim(lsCategoryList[2])
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
		[ ] 
		[ ] 
		[+] if (iResult==PASS)
			[ ] 
			[ ] ////Select categories from Graph View.
			[ ] QuickenWindow.SetActive()
			[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sGraphView)
			[ ] sleep(2)
			[ ] iResult=SelectOneCategoryToBudget(sCategoryType ,sCategory)
			[+] if (iResult==PASS)
				[ ] ReportStatus("Verify category added to the budget.", PASS , "Category: {sCategory} of type: {sCategoryType} couldn't be added to the budget.")
				[ ] 
				[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
				[ ] iListCount =MDIClient.Budget.ListBox.GetItemCount() 
				[ ] ///Verify that category added from Graph View is available at Graph view
				[+] for(iCounter= 1; iCounter <= iListCount;  iCounter++)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCounter))
					[ ] bMatch = MatchStr("*{sCategory}*",sActual)
					[+] if (bMatch)
						[ ] break
				[+] if (bMatch)
					[ ] ReportStatus("Verify that category added from Graph View is available at Graph view.", PASS ,"Category: {sCategory} added from Graph View is available at Graph View.")
				[+] else
					[ ] ReportStatus("Verify that category added from Graph View is available at Graph view.", FAIL ,"Category: {sCategory} added from Graph View is not available at Graph View.")
				[ ] 
				[ ] 
				[ ] ///Verify that category added from Graph View is available at Annual view
				[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sAnnualView)
				[ ] sleep(2)
				[ ] 
				[+] do
					[ ] MDIClient.Budget.TextClick(sCategory)
					[ ] ReportStatus("Verify that category added from Graph View is available at Annual view.", PASS ,"Category: {sCategory} added from Graph View is available at Annual View.")
				[+] except
					[ ] ReportStatus("Verify that category added from Graph View is available at Annual view.", FAIL ,"Category: {sCategory} added from Graph View is not available at Annual View.")
				[ ] 
				[ ] 
				[ ] //Remove added category
				[ ] RemoveCategoryFromBudget(sCategory)
				[ ] 
			[+] else
				[ ] ReportStatus("Verify category added to the budget.", FAIL , "Category: {sCategory} of type: {sCategoryType} couldn't be added to the budget.") 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
[ ] 
[ ] 
[+] //##########Test 100:Verify that selected categories from select Category to Budget dialog in Annual view gets included in Budget Graph as well as Annual view.. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test100_VerifyThatCategoriesAddedFromAnnualViewAreAvailableAtAnnualAndGraphView
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that selected categories from select Category to Budget dialog in Annual view gets included in Budget Graph as well as Annual view
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If selected categories from select Category to Budget dialog in Annual view gets included in Budget Graph as well as Annual viewt
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  July 18  2014
		[ ] //
	[ ] // ********************************************************
[ ] 
[+] testcase Test100_VerifyThatCategoriesAddedFromAnnualViewAreAvailableAtAnnualAndGraphView() appstate none
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] lsCategoryList = lsExcelData[3]
		[ ] sCategoryType =trim(lsCategoryList[1])
		[ ] sCategory=trim(lsCategoryList[2])
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
		[ ] 
		[ ] 
		[+] if (iResult==PASS)
			[ ] 
			[ ] ////Select categories from Annual View.
			[ ] QuickenWindow.SetActive()
			[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sAnnualView) 
			[ ] sleep(2)
			[ ] iResult=SelectOneCategoryToBudget(sCategoryType ,sCategory)
			[+] if (iResult==PASS)
				[ ] ReportStatus("Verify category added to the budget.", PASS , "Category: {sCategory} of type: {sCategoryType} couldn't be added to the budget.")
				[ ] 
				[+] do
					[ ] MDIClient.Budget.TextClick(sCategory)
					[ ] ReportStatus("Verify that category added from Annual View is available at Annual view.", PASS ,"Category: {sCategory} added from Annual View is available at Annual View.")
				[+] except
					[ ] ReportStatus("Verify that category added from Annual View is available at Annual view.", FAIL ,"Category: {sCategory} added from Annual View is not available at Annual View.")
				[ ] 
				[ ] 
				[ ] 
				[ ] ///Verify that category added from Annual View is available at Annual view
				[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sGraphView)
				[ ] sleep(2)
				[ ] 
				[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
				[ ] iListCount =MDIClient.Budget.ListBox.GetItemCount() 
				[ ] ///Verify that category added from Annual View is available at Graph view
				[+] for(iCounter= 1; iCounter <= iListCount;  iCounter++)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCounter))
					[ ] bMatch = MatchStr("*{sCategory}*",sActual)
					[+] if (bMatch)
						[ ] break
				[+] if (bMatch)
					[ ] ReportStatus("Verify that category added from Annual View is available at Graph view.", PASS ,"Category: {sCategory} added from Annual View is available at Graph View.")
				[+] else
					[ ] ReportStatus("Verify that category added from Annual View is available at Graph view.", FAIL ,"Category: {sCategory} added from Annual View is not available at Graph View.")
				[ ] 
				[ ] 
				[ ] //Remove added category
				[ ] RemoveCategoryFromBudget(sCategory)
				[ ] 
			[+] else
				[ ] ReportStatus("Verify category added to the budget.", FAIL , "Category: {sCategory} of type: {sCategoryType} couldn't be added to the budget.") 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
[ ] 
[ ] 
[+] //##########Test 87: Verify that Rollover Help options in Graph view displays rollover help content. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test87_VerifyThatRolloverHelpOptionDisplaysRolloverHelpContentOnGraphView
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that Rollover Help options in Graph view displays rollover help content
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Rollover Help options in Graph view displays rollover help content
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  July 17  2014
		[ ] //
	[ ] // ********************************************************
[ ] 
[+] testcase Test87_VerifyThatRolloverHelpOptionDisplaysRolloverHelpContentOnGraphView() appstate none
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] STRING sRolloverHelpTitle
		[ ] sRolloverHelpTitle = "What is a budget rollover?"
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] lsCategoryList = lsExcelData[1]
		[ ] sCategoryType =trim(lsCategoryList[1])
		[ ] sParentCategory=trim(lsCategoryList[2])
		[ ] sCategory=trim(lsCategoryList[3])
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
		[ ] 
		[ ] 
		[+] if (iResult==PASS)
			[ ] 
			[ ] ////Verify that Rollover Help options in Graph view displays rollover help content on Graph View.
			[ ] QuickenWindow.SetActive()
			[ ] sleep(2)
			[ ] SelectDeselectRollOverOptions(sCategory , sRollOverHelp , TRUE)
			[+] if(QuickenHelp.Exists(5))
				[ ] QuickenHelp.SetActive()
				[+] do
					[ ] QuickenHelp.TextClick(sRolloverHelpTitle)
					[ ] ReportStatus("Verify that Rollover Help options in Graph view displays rollover help content on Graph View.", PASS , "Rollover Help options in Graph view displays rollover help:{sRolloverHelpTitle} content on Graph View.") 
				[+] except
					[ ] ReportStatus("Verify that Rollover Help options in Graph view displays rollover help content on Graph View.", FAIL , "Rollover Help options in Graph view didn't display rollover help:{sRolloverHelpTitle} content on Graph View.") 
				[ ] 
				[ ] QuickenHelp.SetActive()
				[ ] QuickenHelp.Close()
				[ ] WaitForState(QuickenHelp , FALSE , 5)
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
[ ] 
[ ] 
[+] //##########Test 86: Verify that Rollover Help options in Annual view displays rollover help content. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test86_VerifyThatRolloverHelpOptionDisplaysRolloverHelpContentOnAnnualView
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that Rollover Help options in Annual view displays rollover help content
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Rollover Help options in Annual view displays rollover help content
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  July 17  2014
		[ ] //
	[ ] // ********************************************************
[ ] 
[+] testcase Test86_VerifyThatRolloverHelpOptionDisplaysRolloverHelpContentOnAnnualView() appstate none
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] STRING sRolloverHelpTitle
		[ ] sRolloverHelpTitle = "What is a budget rollover?"
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] lsCategoryList = lsExcelData[1]
		[ ] sCategoryType =trim(lsCategoryList[1])
		[ ] sParentCategory=trim(lsCategoryList[2])
		[ ] sCategory=trim(lsCategoryList[3])
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
		[ ] 
		[ ] 
		[+] if (iResult==PASS)
			[ ] 
			[ ] ////Verify that Rollover Help options in Graph view displays rollover help content on Annual View.
			[ ] QuickenWindow.SetActive()
			[ ] SelectDeselectRollOverOptions(sCategory , sRollOverHelp , FALSE)
			[+] if(QuickenHelp.Exists(5))
				[ ] ReportStatus("Verify that Quicken Help displayed." , PASS , "Quicken Help displayed.")
				[ ] QuickenHelp.SetActive()
				[+] do
					[ ] QuickenHelp.TextClick(sRolloverHelpTitle)
					[ ] ReportStatus("Verify that Rollover Help options in Graph view displays rollover help content on Annual View.", PASS , "Rollover Help options in Graph view displays rollover help:{sRolloverHelpTitle} content on Annual View.") 
				[+] except
					[ ] ReportStatus("Verify that Rollover Help options in Graph view displays rollover help content on Annual View.", FAIL , "Rollover Help options in Graph view didn't display rollover help:{sRolloverHelpTitle} content on Annual View.") 
				[ ] 
				[ ] QuickenHelp.SetActive()
				[ ] QuickenHelp.Close()
				[ ] WaitForState(QuickenHelp , FALSE , 5)
			[+] else
				[ ] ReportStatus("Verify that Quicken Help displayed." , FAIL , "Quicken Help didn't display.")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
[ ] 
[ ] 
[+] //##########Test 122: Verify that Quicken help displays help topic about Annual View. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test122_VerifyQuickenHelpDisplaysHelpTopicAboutAnnualView
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that Quicken help displays help topic about Annual View.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Quicken help displays help topic about Annual View.
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  July 19  2014
		[ ] //
	[ ] // ********************************************************
[ ] 
[+] testcase Test122_VerifyQuickenHelpDisplaysHelpTopicAboutAnnualView() appstate none
	[ ] 
	[ ] //--------------Variable Declaration-------------
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] ////Open Quicken help
		[ ] QuickenWindow.TypeKeys(KEY_F1)
		[ ] 
		[+] if(QuickenHelp.Exists(5))
			[ ] sleep(5)
			[ ] ReportStatus("Verify that Quicken Help displayed." , PASS , "Quicken Help displayed.")
			[ ] //Search for the budget help content
			[ ] QuickenHelp.SetActive()
			[ ] QuickenHelp.SearchTextField.SetText("work with a budget")
			[ ] QuickenHelp.iSearchButton.DomClick()
			[ ] sleep(0.5)
			[+] do
				[ ] ////Open the budget help content
				[ ] QuickenHelp.TextClick("How do I work with a budget?")
				[ ] ReportStatus("Verify that 'How do I work with a budget?' displayed in search results.", PASS , " 'How do I work with a budget?' displayed in search results.") 
				[ ] ////Verify the Annual view help content in budget
				[+] do
					[ ] QuickenHelp.TextClick(sAnnualView)
					[ ] ReportStatus("Verify that Quicken help displays help topic about Annual View", PASS , "Quicken help displayed help topic about Annual View.") 
				[+] except
					[ ] ReportStatus("Verify that Quicken help displays help topic about Annual View", FAIL , "Quicken help didn't display help topic about Annual View.") 
					[ ] 
			[+] except
				[ ] ReportStatus("Verify that 'How do I work with a budget?' displayed in search results.", FAIL , " 'How do I work with a budget?' didn't display in search results.") 
			[ ] 
			[ ] QuickenHelp.SetActive()
			[ ] QuickenHelp.Close()
			[ ] WaitForState(QuickenHelp , FALSE , 5)
		[+] else
			[ ] ReportStatus("Verify that Quicken Help displayed." , FAIL , "Quicken Help didn't display.")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
[ ] 
[ ] 
[+] //##########Test 123: Verify the Items and icons present in Budget Actions Drop Down #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test123_VerifyItemsAndIconsPresentInBudget
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify the Items and icons present in Budget Actions Drop Down
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If the verification of Items and icons present in Budget Actions Drop Down
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  July 22  2014
		[ ] //
	[ ] // ********************************************************
[ ] 
[+] testcase Test123_VerifyItemsAndIconsPresentInBudget() appstate none
	[ ] 
	[ ] //--------------Variable Declaration-------------
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
		[+] if (iResult==PASS)
			[ ] QuickenWindow.SetActive()
			[ ] ///Verfiy budget actions for Graph view
			[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sGraphView) 
			[ ] sleep(2)
			[ ] QuickenWindow.SetActive()
			[ ] //Verfiy Select categories to budget option on Graph View
			[ ] MDIClient.Budget.BudgetActions.Click()
			[ ] sleep(1)
			[ ] MDIClient.Budget.BudgetActions.TypeKeys(KEY_DN)
			[ ] sleep(1)
			[ ] MDIClient.Budget.BudgetActions.TypeKeys(KEY_ENTER)
			[+] if (SelectCategoriesToBudget.Exists(4))
				[ ] SelectCategoriesToBudget.SetActive()
				[ ] ReportStatus("Verify that Select categories to budget option present in Budget Actions Drop Down on Graph View.", PASS , "Select categories to budget option present in Budget Actions Drop Down on Graph View.") 
				[ ] SelectCategoriesToBudget.Cancel.Click()
				[ ] WaitForState(SelectCategoriesToBudget , False ,3)
			[+] else
				[ ] ReportStatus("Verify that Select categories to budget option present in Budget Actions Drop Down on Graph View.", FAIL , "Select categories to budget option is not present in Budget Actions Drop Down on Graph View.") 
			[ ] 
			[ ] //Verfiy Switch to annual view option on Graph View
			[ ] QuickenWindow.SetActive()
			[ ] MDIClient.Budget.BudgetActions.Click()
			[ ] sleep(1)
			[ ] MDIClient.Budget.BudgetActions.TypeKeys(replicate(KEY_DN,2))  
			[ ] 
			[ ] MDIClient.Budget.BudgetActions.TypeKeys(KEY_ENTER)
			[ ] sleep(2)
			[+] if (MDIClient.Budget.BudgetViewTypeComboBox.GetSelectedItem()==sAnnualView)
				[ ] ReportStatus("Verify that Switch to annual view option is present in Budget Actions Drop Down on Graph View.", PASS , "Switch to annual view option is present in Budget Actions Drop Down on Graph View.") 
			[+] else
				[ ] ReportStatus("Verify that Switch to annual view option is present in Budget Actions Drop Down on Graph View.", FAIL , "Switch to annual view option is NOT present in Budget Actions Drop Down on Graph View.") 
			[ ] 
			[ ] //Revert to graph view
			[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sGraphView) 
			[ ] 
			[ ] //Verfiy Duplicate budget option on Graph View
			[ ] QuickenWindow.SetActive()
			[ ] MDIClient.Budget.BudgetActions.Click()
			[ ] sleep(1)
			[ ] MDIClient.Budget.BudgetActions.TypeKeys(replicate(KEY_DN,5))  
			[ ] 
			[ ] MDIClient.Budget.BudgetActions.TypeKeys(KEY_ENTER)
			[+] if (DlgDuplicateBudget.Exists(5))
				[ ] ReportStatus("Verify that Duplicate budget option is present in Budget Actions Drop Down on Graph View.", PASS , "Duplicate budget option is present in Budget Actions Drop Down on Graph View.") 
				[ ] DlgDuplicateBudget.SetActive()
				[ ] DlgDuplicateBudget.CancelButton.Click()
				[ ] WaitForState(QuickenWindow,TRUE,2)
			[+] else
				[ ] ReportStatus("Verify that Duplicate budget option is present in Budget Actions Drop Down on Graph View.", FAIL , "Duplicate budget option is not present in Budget Actions Drop Down on Graph View.") 
				[ ] 
			[ ] 
			[ ] 
			[ ] sleep(4)
			[ ] //Verfiy Budget Prefernces option on Graph View
			[ ] QuickenWindow.SetActive()
			[ ] MDIClient.Budget.BudgetActions.Click()
			[ ] sleep(1)
			[ ] MDIClient.Budget.BudgetActions.TypeKeys(replicate(KEY_DN,8))  
			[ ] sleep(1)
			[ ] MDIClient.Budget.BudgetActions.TypeKeys(KEY_ENTER)
			[+] if (DlgBudgetPreferences.Exists(5))
				[ ] ReportStatus("Verify that Budget Prefernces option is present in Budget Actions Drop Down on Graph View.", PASS , "Budget Prefernces option is present in Budget Actions Drop Down on Graph View.") 
				[ ] DlgBudgetPreferences.SetActive()
				[ ] DlgBudgetPreferences.CancelButton.Click()
				[ ] WaitForState(QuickenWindow,TRUE,2)
			[+] else
				[ ] ReportStatus("Verify that Budget Prefernces option is present in Budget Actions Drop Down on Graph View.", FAIL , "Budget Prefernces option is not present in Budget Actions Drop Down on Graph View.") 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] ///Verfiy budget actions for Annual view
			[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sAnnualView) 
			[ ] sleep(2)
			[ ] QuickenWindow.SetActive()
			[ ] //Verfiy Select categories to budget option on Annual View
			[ ] MDIClient.Budget.BudgetActions.Click()
			[ ] sleep(1)
			[ ] MDIClient.Budget.BudgetActions.TypeKeys(KEY_DN)
			[ ] sleep(1)
			[ ] MDIClient.Budget.BudgetActions.TypeKeys(KEY_ENTER)
			[+] if (SelectCategoriesToBudget.Exists(4))
				[ ] SelectCategoriesToBudget.SetActive()
				[ ] ReportStatus("Verify that Select categories to budget option present in Budget Actions Drop Down on Annual View.", PASS , "Select categories to budget option present in Budget Actions Drop Down on Annual View.") 
				[ ] SelectCategoriesToBudget.Cancel.Click()
				[ ] WaitForState(SelectCategoriesToBudget , False ,3)
			[+] else
				[ ] ReportStatus("Verify that Select categories to budget option present in Budget Actions Drop Down on Annual View.", FAIL , "Select categories to budget option is not present in Budget Actions Drop Down on Annual View.") 
			[ ] 
			[ ] //Verfiy Switch to annual view option on Annual View
			[ ] sleep(4)
			[ ] QuickenWindow.SetActive()
			[ ] MDIClient.Budget.BudgetActions.Click()
			[ ] sleep(1)
			[ ] MDIClient.Budget.BudgetActions.TypeKeys(replicate(KEY_DN,2))  
			[ ] sleep(1)
			[ ] MDIClient.Budget.BudgetActions.TypeKeys(KEY_ENTER)
			[ ] sleep(2)
			[+] if (MDIClient.Budget.BudgetViewTypeComboBox.GetSelectedItem()==sGraphView)
				[ ] ReportStatus("Verify that Switch to annual view option is present in Budget Actions Drop Down on Annual View.", PASS , "Switch to annual view option is present in Budget Actions Drop Down on Annual View.") 
			[+] else
				[ ] ReportStatus("Verify that Switch to annual view option is present in Budget Actions Drop Down on Annual View.", FAIL , "Switch to annual view option is NOT present in Budget Actions Drop Down on Annual View.") 
			[ ] 
			[ ] //Revert to graph view
			[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sAnnualView) 
			[ ] sleep(4)
			[ ] //Verfiy Duplicate budget option on Annual View
			[ ] QuickenWindow.SetActive()
			[ ] MDIClient.Budget.BudgetActions.Click()
			[ ] sleep(1)
			[ ] MDIClient.Budget.BudgetActions.TypeKeys(replicate(KEY_DN,5))  
			[ ] sleep(1)
			[ ] MDIClient.Budget.BudgetActions.TypeKeys(KEY_ENTER)
			[+] if (DlgDuplicateBudget.Exists(5))
				[ ] ReportStatus("Verify that Duplicate budget option is present in Budget Actions Drop Down on Annual View.", PASS , "Duplicate budget option is present in Budget Actions Drop Down on Annual View.") 
				[ ] DlgDuplicateBudget.SetActive()
				[ ] DlgDuplicateBudget.CancelButton.Click()
				[ ] WaitForState(QuickenWindow,TRUE,2)
			[+] else
				[ ] ReportStatus("Verify that Duplicate budget option is present in Budget Actions Drop Down on Annual View.", FAIL , "Duplicate budget option is not present in Budget Actions Drop Down on Annual View.") 
				[ ] 
			[ ] 
			[ ] //Verfiy Budget Prefernces option on Annual View
			[ ] sleep(4)
			[ ] QuickenWindow.SetActive()
			[ ] MDIClient.Budget.BudgetActions.Click()
			[ ] sleep(1)
			[ ] MDIClient.Budget.BudgetActions.TypeKeys(replicate(KEY_DN,8))  
			[ ] sleep(1)
			[ ] MDIClient.Budget.BudgetActions.TypeKeys(KEY_ENTER)
			[+] if (DlgBudgetPreferences.Exists(5))
				[ ] ReportStatus("Verify that Budget Prefernces option is present in Budget Actions Drop Down on Annual View.", PASS , "Budget Prefernces option is present in Budget Actions Drop Down on Annual View.") 
				[ ] DlgBudgetPreferences.SetActive()
				[ ] DlgBudgetPreferences.CancelButton.Click()
				[ ] WaitForState(QuickenWindow,TRUE,2)
			[+] else
				[ ] ReportStatus("Verify that Budget Prefernces option is present in Budget Actions Drop Down on Annual View.", FAIL , "Budget Prefernces option is not present in Budget Actions Drop Down on Annual View.") 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
[ ] 
[ ] 
[ ] 
[+] //##########Test 156: Verify 'Set current month budget based on average spending in this category'. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test156_VerifySetCurrentMonthBudgetBasedOnAverageSpendingInThisCategory
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify the 'Set current month budget based on average spending in this category'
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If the verification of 'Set current month budget based on average spending in this category' is successful
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  July 23  2014
		[ ] //
	[ ] // ********************************************************
[ ] 
[+] testcase Test156_VerifySetCurrentMonthBudgetBasedOnAverageSpendingInThisCategory() appstate none
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] //Read transaction sheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sRegTransactionSheet)
		[ ] lsTransaction=lsExcelData[1]
		[ ] iTxnAmount=VAL(lsTransaction[3])
		[ ] sTxnAmount=str(iTxnAmount)
		[ ] //Read categories sheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] lsCategoryList = lsExcelData[1]
		[ ] sCategoryType =trim(lsCategoryList[1])
		[ ] sParentCategory=trim(lsCategoryList[2])
		[ ] sCategory=trim(lsCategoryList[3])
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
		[+] if (iResult==PASS)
			[ ] QuickenWindow.SetActive()
			[ ] ////Select graph view
			[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sGraphView) 
			[ ] //// 'Set current month budget based on average spending in this category'
			[ ] SelectDeselectGearMenuOptions(sCategory , sSetAverageBudgetBasedOnThisCategory)
			[ ] 
			[ ] /// Verify 'Set current month budget based on average spending in this category'.
			[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
			[ ] iListCount= MDIClient.Budget.ListBox.GetItemCount() +1
			[+] for (iCount=1 ; iCount<=iListCount;++iCount)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
				[ ] bResult = MatchStr("*{sCategory}*", sActual)
				[+] if (bResult)
					[ ] bMatch = MatchStr("*{sTxnAmount}*", sActual)
					[+] if(bMatch)
						[ ] ReportStatus("Verify 'Set current month budget based on average spending in this category'." ,PASS, "The budget has been set for category: {sCategory} on Graph View as expected:{sTxnAmount} after applying option 'Set current month budget based on average spending in this category'.")
					[+] else
						[ ] ReportStatus("Verify 'Set current month budget based on average spending in this category'." ,FAIL, "The budget for category: {sCategory} on Graph View couldn't be set as expected:{sTxnAmount} , actual budget is: {sActual} after applying option 'Set current month budget based on average spending in this category'.")
					[ ] break
				[ ] 
			[+] if(bResult==FALSE)
				[ ] ReportStatus("Verify 'Set current month budget based on average spending in this category'." ,FAIL, "Category: {sCategory} couldn't be found on Graph View.")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
[ ] 
[ ] 
[+] //##########Test 88: Verify the functionality of Rollover option 'Roll over only positive balances at the end of each month' in Annual view. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test88_VerifyRolloverOnlyPositiveBalancesFeatureInAnnualView
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify  the functionality of Rollover option 'Roll over only positive balances at the end of each month' in Annual view
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If functionality of Rollover option 'Roll over only positive balances at the end of each month' in Annual view is as expected
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  July 24 2014
	[ ] // ********************************************************
[ ] 
[+] testcase Test88_VerifyRolloverOnlyPositiveBalancesFeatureInAnnualView() appstate none
	[ ] 
	[+] //--------------Variable Declaration------------
		[ ] 
		[ ] STRING sActualYear , sRemainingMonthsAmountPattern
		[ ] BOOLEAN bMatch=FALSE
		[ ] iBudgetAmount=10
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] lsCategoryList=lsExcelData[1]
		[ ] sCategory=lsCategoryList[3]
		[ ] // Fetch 1st row from sRegTransactionSheet the given sheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sRegTransactionSheet)
		[ ] lsTransaction=lsExcelData[1]
		[ ] iTxnAmount=VAL(lsTransaction[3])
		[ ] 
		[ ] sCurrentMonth=FormatDateTime(GetDateTime(), "m") //Get current month as January 2014
		[ ] iCurrentMonth = VAL(sCurrentMonth)
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
		[+] if (iResult==PASS)
			[ ] sleep(2)
			[ ] iResult=DeleteBudget()
			[+] if (iResult==PASS)
				[ ] iResult=AddBudget(sBudgetName)
				[+] if (iResult==PASS)
					[ ] ReportStatus("Verify budget gets added.", PASS, "Budget: {sBudgetName} has been added.")
					[ ] 
					[ ] QuickenWindow.SetActive()
					[ ] 
					[ ] 
					[ ] //// Set Parent rollup on
					[ ] SelectBudgetOptionOnGraphAnnualView(sGraphView,"Rollup")
					[ ] sleep(2)
					[ ] iResult=AddAverageBudget(sCategory ,iBudgetAmount)
					[+] if (iResult==PASS)
						[ ] QuickenWindow.SetActive()
						[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sAnnualView) 
						[ ] sleep(2)
						[ ] ///Enable Rollover 
						[ ] SelectDeselectRollOverOptions(sCategory, sSetPositiveRollOverBalance , FALSE )
						[ ] sleep(2)
						[ ] MDIClient.Budget.AnnualViewTypeComboBox.Select("Balance only")
						[ ] sleep(2)
						[+] if (MDIClient.Budget.ShowBalanceInFutureMonthsCheckBox.Exists(2))
							[ ] MDIClient.Budget.ShowBalanceInFutureMonthsCheckBox.Check()
							[ ] 
						[ ] 
						[ ] 
						[+] ///Create only positive balances rollover data
							[ ] iTxnMonthCount=4
							[ ] iRollOverWithNoTxnMonthAmount=0
							[ ] iRemainingMonths=12 - iCurrentMonth
							[ ] iRemainingMonthsAmount=iRemainingMonths*iBudgetAmount
							[+] if (iRemainingMonthsAmount<0)
								[ ] iRemainingMonthsAmount=0
							[ ] 
							[+] if (iCurrentMonth>4)
								[ ] iRollOverWithNoTxnMonthCount=iCurrentMonth-4
								[ ] iTxnMonthCount=4
							[+] else
								[ ] iTxnMonthCount= iCurrentMonth
								[ ] iRollOverWithNoTxnMonthCount=0
								[ ] 
							[ ] 
							[ ] 
							[ ] 
							[+] if (iTxnMonthCount>1)
								[ ] 
								[ ] ///Get rollover amounts for months for whom there are no transactions
								[+] if (iRollOverWithNoTxnMonthCount > 0)
									[ ] iExpectedNoTxnRollOverAmount=iBudgetAmount
									[ ] sExpectedNoTxnRollOverAmount="@{iExpectedNoTxnRollOverAmount}@"
									[+] for (iCount=2; iCount<=iRollOverWithNoTxnMonthCount; iCount++)
										[ ] sExpectedNoTxnRollOverAmount =sExpectedNoTxnRollOverAmount +"{iBudgetAmount+iExpectedNoTxnRollOverAmount}@"
										[ ] iExpectedNoTxnRollOverAmount=iBudgetAmount+iExpectedNoTxnRollOverAmount
								[+] else
									[ ] sExpectedNoTxnRollOverAmount=""
									[ ] iExpectedNoTxnRollOverAmount=0
								[ ] ///Get rollover amounts for months for whom there are  transactions
								[ ] iDiffOfBudgetTxnAmount= iBudgetAmount-iTxnAmount
								[ ] iExpectedTxnRollOverAmount=iExpectedNoTxnRollOverAmount+iDiffOfBudgetTxnAmount
								[ ] sExpectedTxnRollOverAmount="@{str(iExpectedTxnRollOverAmount)}@"
								[+] for (iCount=2; iCount<=iTxnMonthCount; iCount++)
									[ ] 
									[+] if (iExpectedTxnRollOverAmount>0)
										[ ] iExpectedTxnRollOverAmount= iDiffOfBudgetTxnAmount+iExpectedTxnRollOverAmount
									[+] else
										[ ] iExpectedTxnRollOverAmount= iDiffOfBudgetTxnAmount
									[ ] sExpectedTxnRollOverAmount =sExpectedTxnRollOverAmount +"{iExpectedTxnRollOverAmount}@"
									[ ] 
									[ ] 
									[ ] 
								[ ] 
								[+] if (iExpectedTxnRollOverAmount<0)
									[ ] iExpectedTxnRollOverAmount=0
								[ ] iTotalRolloverAmount=iExpectedTxnRollOverAmount+iRemainingMonthsAmount
							[+] else
								[ ] iExpectedNoTxnRollOverAmount=0
								[ ] iExpectedTxnRollOverAmount=0
								[ ] sExpectedNoTxnRollOverAmount="0"
								[ ] sExpectedTxnRollOverAmount="0"
						[ ] 
						[ ] 
						[ ] ///remaining months pattern
						[ ] iAmount=iBudgetAmount
						[ ] sRemainingMonthsAmountPattern="@{iBudgetAmount}@" 
						[+] for (iCount=2 ; iCount<=iRemainingMonths;++iCount)
							[ ] iAmount=iAmount+iBudgetAmount
							[ ] sRemainingMonthsAmountPattern=sRemainingMonthsAmountPattern +"{iAmount}@"
						[ ] ///monthly budget expected pattern {sRemainingMonthsAmountPattern}
						[ ] sExpectedPattern="{sExpectedNoTxnRollOverAmount}{sExpectedTxnRollOverAmount}*{sRemainingMonthsAmountPattern}{iTotalRolloverAmount}*"
						[ ] sExpectedPattern=StrTran( sExpectedPattern, "@@","@")
						[ ] 
						[ ] ///Verify that budget has been extended as expected.
						[ ] //
						[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
						[ ] iListCount= MDIClient.Budget.ListBox.GetItemCount() +1
						[ ] 
						[ ] sActualYear=MDIClient.Budget.CurrentMonthStaticText.GetText()
						[+] for (iCount=3 ; iCount<=iListCount;++iCount)
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
							[+] // Manipulate sActual to remove extraneous characters otherwise pattern won't match
								[ ] sActual=StrTran( sActual, "<af href=Actual>","")
								[ ] 
								[ ] sActual=StrTran( sActual, "</a>","")
								[ ] sActual=StrTran( sActual, "@@","@")
								[ ] sActual=StrTran( sActual, "@@","@")
								[ ] sActual=StrTran( sActual, "<font style=","")
								[ ] sActual=StrTran( sActual, "color:#ff0000","")
								[ ] sActual=StrTran( sActual, "</font>","")
								[ ] sActual=StrTran( sActual, ">","")
								[ ] 
								[ ] sActual=StrTran( sActual,chr(34),"")
								[ ] 
							[ ] 
							[ ] bMatch = MatchStr(sExpectedPattern, StrTran(sActual,",",""))
							[+] if (bMatch)
								[ ] break
						[+] if(bMatch)
							[ ] ReportStatus("Verify the functionality of Rollover option 'Roll over only positive balances at the end of each month' in Annual view" ,PASS, "The category budget values for category: {sCategory} for 'Roll over only positive balances at the end of each month' in Annual view expected: {sExpectedPattern}")
						[+] else
							[ ] ReportStatus("Verify the functionality of Rollover option 'Roll over only positive balances at the end of each month' in Annual view" ,FAIL, "The category budget values for category: {sCategory} for 'Roll over only positive balances at the end of each month' in Annual view is NOT as expected: {sExpectedPattern}")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify that User is able to add average budget for category: {sCategory} with amount: {iBudgetAmount}."  , FAIL,"Average budget for category: {sCategory} with amount: {iBudgetAmount} couldn't be added for 12 months on Graph View.")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify budget gets added.", FAIL, "Budget: {sBudgetName} couldn't be added.")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify budget gets deleted.", FAIL, "Budget: {sBudgetName} couldn't be deleted.")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
	[ ] 
[ ] 
[ ] 
[+] //##########Test 89: Verify the functionality of Rollover option 'Roll over only positive balances at the end of each month' in Graph view. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test89_VerifyRolloverOnlyPositiveBalancesFeatureInGraphView
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify the functionality of Rollover option 'Roll over only positive balances at the end of each month' in Graph view
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If functionality of Rollover option 'Roll over only positive balances at the end of each month' in Graph view is as expected
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  July 24 2014
	[ ] // ********************************************************
[ ] 
[+] testcase Test89_VerifyRolloverOnlyPositiveBalancesFeatureInGraphView() appstate none
	[ ] 
	[+] //--------------Variable Declaration------------
		[ ] 
		[ ] STRING sActualYear , sRemainingMonthsAmountPattern ,sLeftOver
		[ ] BOOLEAN bMatch=FALSE
		[ ] iBudgetAmount=10
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] lsCategoryList=lsExcelData[1]
		[ ] sCategory=lsCategoryList[3]
		[ ] // Fetch 1st row from sRegTransactionSheet the given sheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sRegTransactionSheet)
		[ ] lsTransaction=lsExcelData[1]
		[ ] iTxnAmount=VAL(lsTransaction[3])
		[ ] 
		[ ] sCurrentMonth=FormatDateTime(GetDateTime(), "m") //Get current month as January 2014
		[ ] iCurrentMonth = VAL(sCurrentMonth)
		[ ] sCurrentYear=FormatDateTime(GetDateTime(),"yyyy")
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
		[+] if (iResult==PASS)
			[ ] sleep(2)
			[ ] iResult=DeleteBudget()
			[+] if (iResult==PASS)
				[ ] iResult=AddBudget(sBudgetName)
				[+] if (iResult==PASS)
					[ ] ReportStatus("Verify budget gets added.", PASS, "Budget: {sBudgetName} has been added.")
					[ ] 
					[ ] QuickenWindow.SetActive()
					[ ] 
					[ ] 
					[ ] //// Set Parent rollup on
					[ ] SelectBudgetOptionOnGraphAnnualView(sGraphView,"Rollup")
					[ ] sleep(2)
					[ ] iResult=AddAverageBudget(sCategory ,iBudgetAmount)
					[+] if (iResult==PASS)
						[ ] QuickenWindow.SetActive()
						[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sGraphView) 
						[ ] sleep(2)
						[ ] ///Enable Rollover 
						[ ] SelectDeselectRollOverOptions(sCategory, sSetPositiveRollOverBalance , TRUE )
						[ ] 
						[ ] 
						[+] ///Create only positive balances rollover data
							[ ] iTxnMonthCount=4
							[ ] iRollOverWithNoTxnMonthAmount=0
							[ ] iRemainingMonths=12 - iCurrentMonth
							[ ] iRemainingMonthsAmount=iRemainingMonths*iBudgetAmount
							[+] if (iRemainingMonthsAmount<0)
								[ ] iRemainingMonthsAmount=0
							[ ] 
							[+] if (iCurrentMonth>4)
								[ ] iRollOverWithNoTxnMonthCount=iCurrentMonth-4
								[ ] iTxnMonthCount=4
							[+] else
								[ ] iTxnMonthCount= iCurrentMonth
								[ ] iRollOverWithNoTxnMonthCount=0
								[ ] 
							[ ] 
							[ ] sActualMonth=MDIClient.Budget.CurrentMonthStaticText.GetText()
							[+] while (sActualMonth!=lsListOfMonths[1]+" "+sCurrentYear)
								[ ] MDIClient.Budget.BackWardMonthButton.Click()
								[ ] sActualMonth=MDIClient.Budget.CurrentMonthStaticText.GetText()
							[ ] 
							[ ] ////Verify the functionality of Rollover option 'Roll over only positive balances at the end of each month' in Graph view///
							[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
							[ ] iListCount= MDIClient.Budget.ListBox.GetItemCount() +1
							[ ] 
							[+] if (iTxnMonthCount>1)
								[ ] 
								[ ] ///Get rollover amounts for months for whom there are no transactions
								[ ] sLeftOver="left"
								[+] if (iRollOverWithNoTxnMonthCount > 0)
									[ ] iExpectedNoTxnRollOverAmount=0
									[+] for (iCounter=1; iCounter<=iRollOverWithNoTxnMonthCount; iCounter++)
										[ ] //Get the month
										[ ] sActualMonth=MDIClient.Budget.CurrentMonthStaticText.GetText()
										[ ] //Calculate rollover for months with no transactions
										[ ] iExpectedNoTxnRollOverAmount=iBudgetAmount+iExpectedNoTxnRollOverAmount
										[+] for (iCount=1 ; iCount<=iListCount;++iCount)
											[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
											[ ] bMatch = MatchStr("*{sCategory}*{iExpectedNoTxnRollOverAmount}*{sLeftOver}*", StrTran(sActual,",",""))
											[+] if (bMatch)
												[ ] break
										[+] if(bMatch)
											[ ] ReportStatus("Verify the functionality of Rollover option 'Roll over only positive balances at the end of each month' in Graph view" ,PASS, "The category budget values for category: {sCategory} for 'Roll over only positive balances at the end of each month' in Graph view expected: {iExpectedNoTxnRollOverAmount} left for the month of: {sActualMonth}")
										[+] else
											[ ] ReportStatus("Verify the functionality of Rollover option 'Roll over only positive balances at the end of each month' in Graph view" ,FAIL, "The category budget values for category: {sCategory} for 'Roll over only positive balances at the end of each month' in Graph view is NOT as expected: {iExpectedNoTxnRollOverAmount} for the month of: {sActualMonth}")
										[ ] ///Go to next month
										[ ] MDIClient.Budget.ForwardMonthButton.Click()
								[+] else
									[ ] sExpectedNoTxnRollOverAmount=""
									[ ] iExpectedNoTxnRollOverAmount=0
									[ ] 
								[ ] iDiffOfBudgetTxnAmount= iBudgetAmount-iTxnAmount
								[+] for (iCounter=1; iCounter<=iTxnMonthCount; iCounter++)
									[ ] ///Get rollover amounts for months for that there are  transactions
									[+] if(iCounter==1)
										[ ] iExpectedTxnRollOverAmount=iExpectedNoTxnRollOverAmount+iDiffOfBudgetTxnAmount
									[+] else
										[+] if (iExpectedTxnRollOverAmount>0)
											[ ] iExpectedTxnRollOverAmount= iDiffOfBudgetTxnAmount+iExpectedTxnRollOverAmount
											[+] if (iExpectedTxnRollOverAmount>0)
												[ ] sLeftOver="left"
											[+] else
												[ ] sLeftOver="over"
										[+] else
											[ ] iExpectedTxnRollOverAmount= iDiffOfBudgetTxnAmount
											[ ] sLeftOver="over"
											[ ] 
									[ ] 
									[ ] 
									[ ] //Get the month
									[ ] sActualMonth=MDIClient.Budget.CurrentMonthStaticText.GetText()
									[ ] //Calculate rollover for months with transactions
									[+] for (iCount=2 ; iCount<=iListCount;++iCount)
										[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
										[ ] 
										[ ] //To compare value negative value needs to be made appear positive
										[+] if (iExpectedTxnRollOverAmount<0)
											[ ] sExpectedTxnRollOverAmount= Str((iExpectedTxnRollOverAmount)*(-1))
										[+] else
											[ ] sExpectedTxnRollOverAmount =Str(iExpectedTxnRollOverAmount)
										[ ] 
										[ ] bMatch = MatchStr("*{sCategory}*{sExpectedTxnRollOverAmount}*{sLeftOver}*", StrTran(sActual,",",""))
										[+] if (bMatch)
											[ ] break
									[+] if(bMatch)
										[ ] ReportStatus("Verify the functionality of Rollover option 'Roll over only positive balances at the end of each month' in Graph view" ,PASS, "The category budget values for category: {sCategory} for 'Roll over only positive balances at the end of each month' in Graph view expected: {sExpectedTxnRollOverAmount} {sLeftOver} for the month of: {sActualMonth}")
									[+] else
										[ ] ReportStatus("Verify the functionality of Rollover option 'Roll over only positive balances at the end of each month' in Graph view" ,FAIL, "The category budget values for category: {sCategory} for 'Roll over only positive balances at the end of each month' in Graph view is NOT as expected: {sExpectedTxnRollOverAmount} for the month of: {sActualMonth}")
									[ ] ///Go to next month
									[ ] MDIClient.Budget.ForwardMonthButton.Click()
									[ ] 
									[ ] 
									[ ] 
								[ ] 
							[+] else
								[ ] iExpectedNoTxnRollOverAmount=0
								[ ] iExpectedTxnRollOverAmount=0
								[ ] sExpectedNoTxnRollOverAmount="0"
								[ ] sExpectedTxnRollOverAmount="0"
						[ ] 
						[ ] iAmount=0
						[ ] sLeftOver="left"
						[ ] ///remaining months pattern
						[+] if (iRemainingMonths>0)
							[+] for (iCounter=1 ; iCounter<=iRemainingMonths;++iCounter)
								[ ] //Get the month
								[ ] sActualMonth=MDIClient.Budget.CurrentMonthStaticText.GetText()
								[ ] 
								[ ] iAmount=iAmount+iBudgetAmount
								[ ] 
								[+] for (iCount=2 ; iCount<=iListCount;++iCount)
									[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
									[ ] bMatch = MatchStr("*{sCategory}*{iAmount}*{sLeftOver}*", StrTran(sActual,",",""))
									[+] if (bMatch)
										[ ] break
								[+] if(bMatch)
									[ ] ReportStatus("Verify the functionality of Rollover option 'Roll over only positive balances at the end of each month' in Graph view" ,PASS, "The category budget values for category: {sCategory} for 'Roll over only positive balances at the end of each month' in Graph view expected: {iAmount} left for the month of: {sActualMonth}")
								[+] else
									[ ] ReportStatus("Verify the functionality of Rollover option 'Roll over only positive balances at the end of each month' in Graph view" ,FAIL, "The category budget values for category: {sCategory} for 'Roll over only positive balances at the end of each month' in Graph view is NOT as expected: {iAmount} for the month of: {sActualMonth}")
								[ ] ///Go to next month
								[ ] MDIClient.Budget.ForwardMonthButton.Click()
								[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify that User is able to add average budget for category: {sCategory} with amount: {iBudgetAmount}."  , FAIL,"Average budget for category: {sCategory} with amount: {iBudgetAmount} couldn't be added for 12 months on Graph View.")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify budget gets added.", FAIL, "Budget: {sBudgetName} couldn't be added.")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify budget gets deleted.", FAIL, "Budget: {sBudgetName} couldn't be deleted.")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
	[ ] 
[ ] 
[+] //##########Test 90: Verify the functionality of Rollover option 'Roll Over balances at the end of each month.' in Graph view.. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test90_VerifyRolloverBalancesATheEndOfEachMonthFeatureInGraphView
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify the functionality of Rollover option 'Roll Over balances at the end of each month.' in Graph view
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If functionality of Rollover option 'Roll Over balances at the end of each month.' in Graph view is as expected
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  July 28 2014
	[ ] // ********************************************************
[ ] 
[+] testcase Test90_VerifyRolloverBalancesATheEndOfEachMonthFeatureInGraphView() appstate none
	[ ] 
	[+] //--------------Variable Declaration------------
		[ ] 
		[ ] STRING sActualYear , sRemainingMonthsAmountPattern ,sLeftOver
		[ ] BOOLEAN bMatch=FALSE
		[ ] iBudgetAmount=50
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] lsCategoryList=lsExcelData[1]
		[ ] sCategory=lsCategoryList[3]
		[ ] // Fetch 1st row from sRegTransactionSheet the given sheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sRegTransactionSheet)
		[ ] lsTransaction=lsExcelData[1]
		[ ] iTxnAmount=VAL(lsTransaction[3])
		[ ] 
		[ ] sCurrentMonth=FormatDateTime(GetDateTime(), "m") //Get current month as January 2014
		[ ] iCurrentMonth = VAL(sCurrentMonth)
		[ ] sCurrentYear=FormatDateTime(GetDateTime(),"yyyy")
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
		[+] if (iResult==PASS)
			[ ] sleep(2)
			[ ] iResult=DeleteBudget()
			[+] if (iResult==PASS)
				[ ] iResult=AddBudget(sBudgetName)
				[+] if (iResult==PASS)
					[ ] ReportStatus("Verify budget gets added.", PASS, "Budget: {sBudgetName} has been added.")
					[ ] 
					[ ] QuickenWindow.SetActive()
					[ ] 
					[ ] 
					[ ] //// Set Parent rollup on
					[ ] SelectBudgetOptionOnGraphAnnualView(sGraphView,"Rollup")
					[ ] sleep(2)
					[ ] iResult=AddAverageBudget(sCategory ,iBudgetAmount)
					[+] if (iResult==PASS)
						[ ] QuickenWindow.SetActive()
						[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sGraphView) 
						[ ] sleep(2)
						[ ] ///Enable Rollover 
						[ ] SelectDeselectRollOverOptions(sCategory, sSetRollOverBalance , TRUE )
						[ ] 
						[ ] 
						[+] ///Create only positive balances rollover data
							[ ] iTxnMonthCount=4
							[ ] iRollOverWithNoTxnMonthAmount=0
							[ ] iRemainingMonths=12 - iCurrentMonth
							[ ] iRemainingMonthsAmount=iRemainingMonths*iBudgetAmount
							[+] if (iRemainingMonthsAmount<0)
								[ ] iRemainingMonthsAmount=0
							[ ] 
							[+] if (iCurrentMonth>4)
								[ ] iRollOverWithNoTxnMonthCount=iCurrentMonth-4
								[ ] iTxnMonthCount=4
							[+] else
								[ ] iTxnMonthCount= iCurrentMonth
								[ ] iRollOverWithNoTxnMonthCount=0
								[ ] 
							[ ] 
							[ ] sActualMonth=MDIClient.Budget.CurrentMonthStaticText.GetText()
							[+] while (sActualMonth!=lsListOfMonths[1]+" "+sCurrentYear)
								[ ] MDIClient.Budget.BackWardMonthButton.Click()
								[ ] sActualMonth=MDIClient.Budget.CurrentMonthStaticText.GetText()
							[ ] 
							[ ] ////Verify the functionality of Rollover option 'Roll Over balances at the end of each month' in Graph view///
							[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
							[ ] iListCount= MDIClient.Budget.ListBox.GetItemCount() +1
							[ ] 
							[+] if (iTxnMonthCount>1)
								[ ] 
								[ ] ///Get rollover amounts for months for whom there are no transactions
								[ ] sLeftOver="left"
								[+] if (iRollOverWithNoTxnMonthCount > 0)
									[ ] iExpectedNoTxnRollOverAmount=0
									[+] for (iCounter=1; iCounter<=iRollOverWithNoTxnMonthCount; iCounter++)
										[ ] //Get the month
										[ ] sActualMonth=MDIClient.Budget.CurrentMonthStaticText.GetText()
										[ ] //Calculate rollover for months with no transactions
										[ ] iExpectedNoTxnRollOverAmount=iBudgetAmount+iExpectedNoTxnRollOverAmount
										[+] for (iCount=2 ; iCount<=iListCount;++iCount)
											[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
											[ ] bMatch = MatchStr("*{sCategory}*{iExpectedNoTxnRollOverAmount}*{sLeftOver}*", StrTran(sActual,",",""))
											[+] if (bMatch)
												[ ] break
										[+] if(bMatch)
											[ ] ReportStatus("Verify the functionality of Rollover option 'Roll Over balances at the end of each month' in Graph view" ,PASS, "The category budget values for category: {sCategory} for 'Roll Over balances at the end of each month' in Graph view expected: {iExpectedNoTxnRollOverAmount} left for the month of: {sActualMonth}")
										[+] else
											[ ] ReportStatus("Verify the functionality of Rollover option 'Roll Over balances at the end of each month' in Graph view" ,FAIL, "The category budget values for category: {sCategory} for 'Roll Over balances at the end of each month' in Graph view is NOT as expected: {iExpectedNoTxnRollOverAmount} for the month of: {sActualMonth}")
										[ ] ///Go to next month
										[ ] MDIClient.Budget.ForwardMonthButton.Click()
								[+] else
									[ ] sExpectedNoTxnRollOverAmount=""
									[ ] iExpectedNoTxnRollOverAmount=0
									[ ] 
								[ ] iDiffOfBudgetTxnAmount= iBudgetAmount-iTxnAmount
								[+] for (iCounter=1; iCounter<=iTxnMonthCount; iCounter++)
									[ ] ///Get rollover amounts for months for that there are  transactions
									[+] if(iCounter==1)
										[ ] iExpectedTxnRollOverAmount=iExpectedNoTxnRollOverAmount+iDiffOfBudgetTxnAmount
									[+] else
										[ ] iExpectedTxnRollOverAmount= iDiffOfBudgetTxnAmount+iExpectedTxnRollOverAmount
									[+] if (iExpectedTxnRollOverAmount>0)
										[ ] sLeftOver="left"
									[+] else
										[ ] sLeftOver="over"
										[ ] 
									[ ] 
									[ ] 
									[ ] //Get the month
									[ ] sActualMonth=MDIClient.Budget.CurrentMonthStaticText.GetText()
									[ ] //Calculate rollover for months with transactions
									[+] for (iCount=2 ; iCount<=iListCount;++iCount)
										[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
										[ ] 
										[ ] //To compare value negative value needs to be made appear positive
										[+] if (iExpectedTxnRollOverAmount<0)
											[ ] sExpectedTxnRollOverAmount= Str((iExpectedTxnRollOverAmount)*(-1))
										[+] else
											[ ] sExpectedTxnRollOverAmount =Str(iExpectedTxnRollOverAmount)
										[ ] 
										[ ] bMatch = MatchStr("*{sCategory}*{sExpectedTxnRollOverAmount}*{sLeftOver}*", StrTran(sActual,",",""))
										[+] if (bMatch)
											[ ] break
									[+] if(bMatch)
										[ ] ReportStatus("Verify the functionality of Rollover option 'Roll Over balances at the end of each month' in Graph view" ,PASS, "The category budget values for category: {sCategory} for 'Roll Over balances at the end of each month' in Graph view expected: {sExpectedTxnRollOverAmount} {sLeftOver} for the month of: {sActualMonth}")
									[+] else
										[ ] ReportStatus("Verify the functionality of Rollover option 'Roll Over balances at the end of each month' in Graph view" ,FAIL, "The category budget values for category: {sCategory} for 'Roll Over balances at the end of each month' in Graph view is NOT as expected: {sExpectedTxnRollOverAmount} for the month of: {sActualMonth}")
									[ ] ///Go to next month
									[ ] MDIClient.Budget.ForwardMonthButton.Click()
									[ ] 
									[ ] 
									[ ] 
								[ ] 
							[+] else
								[ ] iExpectedNoTxnRollOverAmount=0
								[ ] iExpectedTxnRollOverAmount=0
								[ ] sExpectedNoTxnRollOverAmount="0"
								[ ] sExpectedTxnRollOverAmount="0"
						[ ] 
						[ ] iAmount=iExpectedTxnRollOverAmount
						[ ] sLeftOver="left"
						[ ] ///remaining months pattern
						[+] if (iRemainingMonths>0)
							[+] for (iCounter=1 ; iCounter<=iRemainingMonths;++iCounter)
								[ ] //Get the month
								[ ] sActualMonth=MDIClient.Budget.CurrentMonthStaticText.GetText()
								[ ] 
								[ ] iAmount=iAmount+iBudgetAmount
								[ ] 
								[+] for (iCount=2 ; iCount<=iListCount;++iCount)
									[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
									[ ] bMatch = MatchStr("*{sCategory}*{iAmount}*{sLeftOver}*", StrTran(sActual,",",""))
									[+] if (bMatch)
										[ ] break
								[+] if(bMatch)
									[ ] ReportStatus("Verify the functionality of Rollover option 'Roll Over balances at the end of each month' in Graph view" ,PASS, "The category budget values for category: {sCategory} for 'Roll Over balances at the end of each month' in Graph view expected: {iAmount} left for the month of: {sActualMonth}")
								[+] else
									[ ] ReportStatus("Verify the functionality of Rollover option 'Roll Over balances at the end of each month' in Graph view" ,FAIL, "The category budget values for category: {sCategory} for 'Roll Over balances at the end of each month' in Graph view is NOT as expected: {iAmount} for the month of: {sActualMonth}")
								[ ] ///Go to next month
								[+] if (iCounter < iRemainingMonths)
									[ ] MDIClient.Budget.ForwardMonthButton.Click()
								[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify that User is able to add average budget for category: {sCategory} with amount: {iBudgetAmount}."  , FAIL,"Average budget for category: {sCategory} with amount: {iBudgetAmount} couldn't be added for 12 months on Graph View.")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify budget gets added.", FAIL, "Budget: {sBudgetName} couldn't be added.")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify budget gets deleted.", FAIL, "Budget: {sBudgetName} couldn't be deleted.")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
	[ ] 
[ ] 
[ ] 
[+] //##########Test 155A: Verify Calculate Average Budget with Rollover option 'Roll Over balances at the end of each month' from gear icon. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test155A_VerifyCalculateAverageBudgetWithRolloverAtTheEndOfTheMonthFromGearIconInGraphView
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify the functionality of Calculate Average Budget with Rollover option 'Roll Over balances at the end of each month' from gear icon in Graph view
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If functionality of Calculate Average Budget with Rollover option 'Roll Over balances at the end of each month' from gear icon in Graph view is as expected
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  July 28 2014
	[ ] // ********************************************************
[ ] 
[+] testcase Test155A_VerifyCalculateAverageBudgetWithRolloverAtTheEndOfTheMonthFromGearIconInGraphView() appstate none
	[ ] 
	[+] //--------------Variable Declaration------------
		[ ] 
		[ ] STRING sActualYear , sRemainingMonthsAmountPattern ,sLeftOver
		[ ] BOOLEAN bMatch=FALSE
		[ ] iBudgetAmount=50
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] lsCategoryList=lsExcelData[1]
		[ ] sCategory=lsCategoryList[3]
		[ ] // Fetch 1st row from sRegTransactionSheet the given sheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sRegTransactionSheet)
		[ ] lsTransaction=lsExcelData[1]
		[ ] iTxnAmount=VAL(lsTransaction[3])
		[ ] 
		[ ] sCurrentMonth=FormatDateTime(GetDateTime(), "m") //Get current month as January 2014
		[ ] iCurrentMonth = VAL(sCurrentMonth)
		[ ] sCurrentYear=FormatDateTime(GetDateTime(),"yyyy")
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
		[+] if (iResult==PASS)
			[ ] sleep(2)
			[ ] iResult=DeleteBudget()
			[+] if (iResult==PASS)
				[ ] iResult=AddBudget(sBudgetName)
				[+] if (iResult==PASS)
					[ ] ReportStatus("Verify budget gets added.", PASS, "Budget: {sBudgetName} has been added.")
					[ ] 
					[ ] QuickenWindow.SetActive()
					[ ] 
					[ ] 
					[ ] //// Set Parent rollup on
					[ ] SelectBudgetOptionOnGraphAnnualView(sGraphView,"Rollup")
					[ ] sleep(2)
					[ ] SelectDeselectGearMenuOptions(sCategory , sCalculateAverageBudget )
					[+] if(DlgCalculateAverageBudget.Exists(5))
						[ ] DlgCalculateAverageBudget.SetActive()
						[ ] DlgCalculateAverageBudget.BudgetTextField.SetText(Str(iBudgetAmount))
						[ ] DlgCalculateAverageBudget.ApplyComboBox.Select("to all of 201*")
						[ ] DlgCalculateAverageBudget.SetActive()
						[ ] //Enable Rollover option 'Roll Over balances at the end of each month'
						[ ] DlgCalculateAverageBudget.RolloverOptionsButton.Click()
						[ ] sleep(1)
						[ ] DlgCalculateAverageBudget.TypeKeys(replicate(KEY_DN,2))
						[ ] sleep(0.5)
						[ ] DlgCalculateAverageBudget.TypeKeys(KEY_ENTER)
						[ ] 
						[ ] 
						[ ] DlgCalculateAverageBudget.OKButton.Click()
						[ ] WaitForState(DlgCalculateAverageBudget , False , 5)
						[ ] 
						[ ] QuickenWindow.SetActive()
						[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sGraphView) 
						[ ] sleep(2)
						[ ] 
						[ ] 
						[+] ///Create only positive balances rollover data
							[ ] iTxnMonthCount=4
							[ ] iRollOverWithNoTxnMonthAmount=0
							[ ] iRemainingMonths=12 - iCurrentMonth
							[ ] iRemainingMonthsAmount=iRemainingMonths*iBudgetAmount
							[+] if (iRemainingMonthsAmount<0)
								[ ] iRemainingMonthsAmount=0
							[ ] 
							[+] if (iCurrentMonth>4)
								[ ] iRollOverWithNoTxnMonthCount=iCurrentMonth-4
								[ ] iTxnMonthCount=4
							[+] else
								[ ] iTxnMonthCount= iCurrentMonth
								[ ] iRollOverWithNoTxnMonthCount=0
								[ ] 
							[ ] 
							[ ] sActualMonth=MDIClient.Budget.CurrentMonthStaticText.GetText()
							[+] while (sActualMonth!=lsListOfMonths[1]+" "+sCurrentYear)
								[ ] MDIClient.Budget.BackWardMonthButton.Click()
								[ ] sActualMonth=MDIClient.Budget.CurrentMonthStaticText.GetText()
							[ ] 
							[ ] ////Verify the functionality of Rollover option 'Roll Over balances at the end of each month' in Graph view///
							[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
							[ ] iListCount= MDIClient.Budget.ListBox.GetItemCount() +1
							[ ] 
							[+] if (iTxnMonthCount>1)
								[ ] 
								[ ] ///Get rollover amounts for months for whom there are no transactions
								[ ] sLeftOver="left"
								[+] if (iRollOverWithNoTxnMonthCount > 0)
									[ ] iExpectedNoTxnRollOverAmount=0
									[+] for (iCounter=1; iCounter<=iRollOverWithNoTxnMonthCount; iCounter++)
										[ ] //Get the month
										[ ] sActualMonth=MDIClient.Budget.CurrentMonthStaticText.GetText()
										[ ] //Calculate rollover for months with no transactions
										[ ] iExpectedNoTxnRollOverAmount=iBudgetAmount+iExpectedNoTxnRollOverAmount
										[+] for (iCount=2 ; iCount<=iListCount;++iCount)
											[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
											[ ] bMatch = MatchStr("*{sCategory}*{iExpectedNoTxnRollOverAmount}*{sLeftOver}*", StrTran(sActual,",",""))
											[+] if (bMatch)
												[ ] break
										[+] if(bMatch)
											[ ] ReportStatus("Verify Create Average Budget with Rollover option 'Roll Over balances at the end of each month' in Graph view" ,PASS, "The category average budget values for category: {sCategory} for 'Roll Over balances at the end of each month' in Graph view expected: {iExpectedNoTxnRollOverAmount} left for the month of: {sActualMonth}")
										[+] else
											[ ] ReportStatus("Verify Create Average Budget with Rollover option 'Roll Over balances at the end of each month' in Graph view" ,FAIL, "The category average budget values for category: {sCategory} for 'Roll Over balances at the end of each month' in Graph view is NOT as expected: {iExpectedNoTxnRollOverAmount} for the month of: {sActualMonth}")
										[ ] ///Go to next month
										[ ] MDIClient.Budget.ForwardMonthButton.Click()
								[+] else
									[ ] sExpectedNoTxnRollOverAmount=""
									[ ] iExpectedNoTxnRollOverAmount=0
									[ ] 
								[ ] iDiffOfBudgetTxnAmount= iBudgetAmount-iTxnAmount
								[+] for (iCounter=1; iCounter<=iTxnMonthCount; iCounter++)
									[ ] ///Get rollover amounts for months for that there are  transactions
									[+] if(iCounter==1)
										[ ] iExpectedTxnRollOverAmount=iExpectedNoTxnRollOverAmount+iDiffOfBudgetTxnAmount
									[+] else
										[ ] iExpectedTxnRollOverAmount= iDiffOfBudgetTxnAmount+iExpectedTxnRollOverAmount
									[+] if (iExpectedTxnRollOverAmount>0)
										[ ] sLeftOver="left"
									[+] else
										[ ] sLeftOver="over"
										[ ] 
									[ ] 
									[ ] 
									[ ] //Get the month
									[ ] sActualMonth=MDIClient.Budget.CurrentMonthStaticText.GetText()
									[ ] //Calculate rollover for months with transactions
									[+] for (iCount=2 ; iCount<=iListCount;++iCount)
										[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
										[ ] 
										[ ] //To compare value negative value needs to be made appear positive
										[+] if (iExpectedTxnRollOverAmount<0)
											[ ] sExpectedTxnRollOverAmount= Str((iExpectedTxnRollOverAmount)*(-1))
										[+] else
											[ ] sExpectedTxnRollOverAmount =Str(iExpectedTxnRollOverAmount)
										[ ] 
										[ ] bMatch = MatchStr("*{sCategory}*{sExpectedTxnRollOverAmount}*{sLeftOver}*", StrTran(sActual,",",""))
										[+] if (bMatch)
											[ ] break
										[+] if(bMatch)
											[ ] ReportStatus("Verify Create Average Budget with Rollover option 'Roll Over balances at the end of each month' in Graph view" ,PASS, "The category average budget values for category: {sCategory} for 'Roll Over balances at the end of each month' in Graph view expected: {sExpectedTxnRollOverAmount} left for the month of: {sActualMonth}")
										[+] else
											[ ] ReportStatus("Verify Create Average Budget with Rollover option 'Roll Over balances at the end of each month' in Graph view" ,FAIL, "The category average budget values for category: {sCategory} for 'Roll Over balances at the end of each month' in Graph view is NOT as expected: {sExpectedTxnRollOverAmount} for the month of: {sActualMonth}")
									[ ] ///Go to next month
									[ ] MDIClient.Budget.ForwardMonthButton.Click()
									[ ] 
									[ ] 
									[ ] 
								[ ] 
							[+] else
								[ ] iExpectedNoTxnRollOverAmount=0
								[ ] iExpectedTxnRollOverAmount=0
								[ ] sExpectedNoTxnRollOverAmount="0"
								[ ] sExpectedTxnRollOverAmount="0"
						[ ] 
						[ ] iAmount=iExpectedTxnRollOverAmount
						[ ] sLeftOver="left"
						[ ] ///remaining months pattern
						[+] if (iRemainingMonths>0)
							[+] for (iCounter=1 ; iCounter<=iRemainingMonths;++iCounter)
								[ ] //Get the month
								[ ] sActualMonth=MDIClient.Budget.CurrentMonthStaticText.GetText()
								[ ] 
								[ ] iAmount=iAmount+iBudgetAmount
								[ ] 
								[+] for (iCount=2 ; iCount<=iListCount;++iCount)
									[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
									[ ] bMatch = MatchStr("*{sCategory}*{iAmount}*{sLeftOver}*", StrTran(sActual,",",""))
									[+] if (bMatch)
										[ ] break
								[+] if(bMatch)
									[ ] ReportStatus("Verify Create Average Budget with Rollover option 'Roll Over balances at the end of each month' in Graph view" ,PASS, "The category average budget values for category: {sCategory} for 'Roll Over balances at the end of each month' in Graph view expected: {iAmount} left for the month of: {sActualMonth}")
								[+] else
									[ ] ReportStatus("Verify Create Average Budget with Rollover option 'Roll Over balances at the end of each month' in Graph view" ,FAIL, "The category average budget values for category: {sCategory} for 'Roll Over balances at the end of each month' in Graph view is NOT as expected: {iAmount} for the month of: {sActualMonth}")
								[ ] ///Go to next month
								[+] if (iCounter < iRemainingMonths)
									[ ] MDIClient.Budget.ForwardMonthButton.Click()
								[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify that User is able to launch the calculate average budget using gear option associated with category."  , FAIL,"Calculte Average Budget didn't appear using gear option associated with category on Graph View.")
						[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify budget gets added.", FAIL, "Budget: {sBudgetName} couldn't be added.")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify budget gets deleted.", FAIL, "Budget: {sBudgetName} couldn't be deleted.")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
	[ ] 
[ ] 
[ ] 
[+] //##########Test 155B: Verify Calculate Average Budget with Rollover option 'Roll over only positive balances at the end of each month' from gear icon on Graph View. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test155B_VerifyCalculateAverageBudgetWithRolloverOnlyPositiveBalancesGearIconInGraphView
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify the functionality of Calculate Average Budget with Rollover option 'Roll over only positive balances at the end of each month' from gear icon on Graph View
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If functionality of Calculate Average Budget with Rollover option 'Roll over only positive balances at the end of each month' from gear icon in Graph view is as expected
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  July 28 2014
	[ ] // ********************************************************
[ ] 
[+] testcase Test155B_VerifyCalculateAverageBudgetWithRolloverOnlyPositiveBalancesGearIconInGraphView() appstate none
	[ ] 
	[+] //--------------Variable Declaration------------
		[ ] 
		[ ] STRING sActualYear , sRemainingMonthsAmountPattern ,sLeftOver
		[ ] BOOLEAN bMatch=FALSE
		[ ] iBudgetAmount=10
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] lsCategoryList=lsExcelData[1]
		[ ] sCategory=lsCategoryList[3]
		[ ] // Fetch 1st row from sRegTransactionSheet the given sheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sRegTransactionSheet)
		[ ] lsTransaction=lsExcelData[1]
		[ ] iTxnAmount=VAL(lsTransaction[3])
		[ ] 
		[ ] sCurrentMonth=FormatDateTime(GetDateTime(), "m") //Get current month as January 2014
		[ ] iCurrentMonth = VAL(sCurrentMonth)
		[ ] sCurrentYear=FormatDateTime(GetDateTime(),"yyyy")
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
		[+] if (iResult==PASS)
			[ ] sleep(2)
			[ ] iResult=DeleteBudget()
			[+] if (iResult==PASS)
				[ ] iResult=AddBudget(sBudgetName)
				[+] if (iResult==PASS)
					[ ] ReportStatus("Verify budget gets added.", PASS, "Budget: {sBudgetName} has been added.")
					[ ] 
					[ ] QuickenWindow.SetActive()
					[ ] 
					[ ] 
					[ ] //// Set Parent rollup on
					[ ] SelectBudgetOptionOnGraphAnnualView(sGraphView,"Rollup")
					[ ] sleep(2)
					[ ] SelectDeselectGearMenuOptions(sCategory , sCalculateAverageBudget )
					[+] if(DlgCalculateAverageBudget.Exists(5))
						[ ] DlgCalculateAverageBudget.SetActive()
						[ ] DlgCalculateAverageBudget.BudgetTextField.SetText(Str(iBudgetAmount))
						[ ] DlgCalculateAverageBudget.ApplyComboBox.Select("to all of 201*")
						[ ] DlgCalculateAverageBudget.SetActive()
						[ ] //Enable Rollover option 'Roll over only positive balances at the end of each month'
						[ ] DlgCalculateAverageBudget.RolloverOptionsButton.Click()
						[ ] sleep(1)
						[ ] DlgCalculateAverageBudget.TypeKeys(replicate(KEY_DN,3))
						[ ] sleep(0.5)
						[ ] DlgCalculateAverageBudget.TypeKeys(KEY_ENTER)
						[ ] 
						[ ] 
						[ ] DlgCalculateAverageBudget.OKButton.Click()
						[ ] WaitForState(DlgCalculateAverageBudget , False , 5)
						[ ] 
						[ ] QuickenWindow.SetActive()
						[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sGraphView) 
						[ ] sleep(2)
						[ ] 
						[ ] 
						[+] ///Create only positive balances rollover data
							[ ] iTxnMonthCount=4
							[ ] iRollOverWithNoTxnMonthAmount=0
							[ ] iRemainingMonths=12 - iCurrentMonth
							[ ] iRemainingMonthsAmount=iRemainingMonths*iBudgetAmount
							[+] if (iRemainingMonthsAmount<0)
								[ ] iRemainingMonthsAmount=0
							[ ] 
							[+] if (iCurrentMonth>4)
								[ ] iRollOverWithNoTxnMonthCount=iCurrentMonth-4
								[ ] iTxnMonthCount=4
							[+] else
								[ ] iTxnMonthCount= iCurrentMonth
								[ ] iRollOverWithNoTxnMonthCount=0
								[ ] 
							[ ] 
							[ ] sActualMonth=MDIClient.Budget.CurrentMonthStaticText.GetText()
							[+] while (sActualMonth!=lsListOfMonths[1]+" "+sCurrentYear)
								[ ] MDIClient.Budget.BackWardMonthButton.Click()
								[ ] sActualMonth=MDIClient.Budget.CurrentMonthStaticText.GetText()
							[ ] 
							[ ] ////Verify the functionality of Rollover option 'Roll over only positive balances at the end of each month' in Graph view///
							[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
							[ ] iListCount= MDIClient.Budget.ListBox.GetItemCount() +1
							[ ] 
							[+] if (iTxnMonthCount>1)
								[ ] 
								[ ] ///Get rollover amounts for months for whom there are no transactions
								[ ] sLeftOver="left"
								[+] if (iRollOverWithNoTxnMonthCount > 0)
									[ ] iExpectedNoTxnRollOverAmount=0
									[+] for (iCounter=1; iCounter<=iRollOverWithNoTxnMonthCount; iCounter++)
										[ ] //Get the month
										[ ] sActualMonth=MDIClient.Budget.CurrentMonthStaticText.GetText()
										[ ] //Calculate rollover for months with no transactions
										[ ] iExpectedNoTxnRollOverAmount=iBudgetAmount+iExpectedNoTxnRollOverAmount
										[+] for (iCount=1 ; iCount<=iListCount;++iCount)
											[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
											[ ] bMatch = MatchStr("*{sCategory}*{iExpectedNoTxnRollOverAmount}*{sLeftOver}*", StrTran(sActual,",",""))
											[+] if (bMatch)
												[ ] break
										[+] if(bMatch)
											[ ] ReportStatus("Verify Create Average Budget with Rollover option 'Roll over only positive balances at the end of each month' in Graph view" ,PASS, "The category budget values for category: {sCategory} for 'Roll over only positive balances at the end of each month' in Graph view expected: {iExpectedNoTxnRollOverAmount} left for the month of: {sActualMonth}")
										[+] else
											[ ] ReportStatus("Verify Create Average Budget with Rollover option 'Roll over only positive balances at the end of each month' in Graph view" ,FAIL, "The category budget values for category: {sCategory} for 'Roll over only positive balances at the end of each month' in Graph view is NOT as expected: {iExpectedNoTxnRollOverAmount} for the month of: {sActualMonth}")
										[ ] ///Go to next month
										[ ] MDIClient.Budget.ForwardMonthButton.Click()
								[+] else
									[ ] sExpectedNoTxnRollOverAmount=""
									[ ] iExpectedNoTxnRollOverAmount=0
									[ ] 
								[ ] iDiffOfBudgetTxnAmount= iBudgetAmount-iTxnAmount
								[+] for (iCounter=1; iCounter<=iTxnMonthCount; iCounter++)
									[ ] ///Get rollover amounts for months for that there are  transactions
									[+] if(iCounter==1)
										[ ] iExpectedTxnRollOverAmount=iExpectedNoTxnRollOverAmount+iDiffOfBudgetTxnAmount
									[+] else
										[+] if (iExpectedTxnRollOverAmount>0)
											[ ] iExpectedTxnRollOverAmount= iDiffOfBudgetTxnAmount+iExpectedTxnRollOverAmount
											[+] if (iExpectedTxnRollOverAmount>0)
												[ ] sLeftOver="left"
											[+] else
												[ ] sLeftOver="over"
										[+] else
											[ ] iExpectedTxnRollOverAmount= iDiffOfBudgetTxnAmount
											[ ] sLeftOver="over"
											[ ] 
									[ ] 
									[ ] 
									[ ] //Get the month
									[ ] sActualMonth=MDIClient.Budget.CurrentMonthStaticText.GetText()
									[ ] //Calculate rollover for months with transactions
									[+] for (iCount=2 ; iCount<=iListCount;++iCount)
										[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
										[ ] 
										[ ] //To compare value negative value needs to be made appear positive
										[+] if (iExpectedTxnRollOverAmount<0)
											[ ] sExpectedTxnRollOverAmount= Str((iExpectedTxnRollOverAmount)*(-1))
										[+] else
											[ ] sExpectedTxnRollOverAmount =Str(iExpectedTxnRollOverAmount)
										[ ] 
										[ ] bMatch = MatchStr("*{sCategory}*{sExpectedTxnRollOverAmount}*{sLeftOver}*", StrTran(sActual,",",""))
										[+] if (bMatch)
											[ ] break
									[+] if(bMatch)
										[ ] ReportStatus("Verify Create Average Budget with Rollover option 'Roll over only positive balances at the end of each month' in Graph view" ,PASS, "The category budget values for category: {sCategory} for 'Roll over only positive balances at the end of each month' in Graph view expected: {sExpectedTxnRollOverAmount} {sLeftOver} for the month of: {sActualMonth}")
									[+] else
										[ ] ReportStatus("Verify Create Average Budget with Rollover option 'Roll over only positive balances at the end of each month' in Graph view" ,FAIL, "The category budget values for category: {sCategory} for 'Roll over only positive balances at the end of each month' in Graph view is NOT as expected: {sExpectedTxnRollOverAmount} for the month of: {sActualMonth}")
									[ ] ///Go to next month
									[ ] MDIClient.Budget.ForwardMonthButton.Click()
									[ ] 
									[ ] 
									[ ] 
								[ ] 
							[+] else
								[ ] iExpectedNoTxnRollOverAmount=0
								[ ] iExpectedTxnRollOverAmount=0
								[ ] sExpectedNoTxnRollOverAmount="0"
								[ ] sExpectedTxnRollOverAmount="0"
						[ ] 
						[ ] iAmount=0
						[ ] sLeftOver="left"
						[ ] ///remaining months pattern
						[+] if (iRemainingMonths>0)
							[+] for (iCounter=1 ; iCounter<=iRemainingMonths;++iCounter)
								[ ] //Get the month
								[ ] sActualMonth=MDIClient.Budget.CurrentMonthStaticText.GetText()
								[ ] 
								[ ] iAmount=iAmount+iBudgetAmount
								[ ] 
								[+] for (iCount=2 ; iCount<=iListCount;++iCount)
									[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
									[ ] bMatch = MatchStr("*{sCategory}*{iAmount}*{sLeftOver}*", StrTran(sActual,",",""))
									[+] if (bMatch)
										[ ] break
								[+] if(bMatch)
									[ ] ReportStatus("Verify Create Average Budget with Rollover option 'Roll over only positive balances at the end of each month' in Graph view" ,PASS, "The category budget values for category: {sCategory} for 'Roll over only positive balances at the end of each month' in Graph view expected: {iAmount} left for the month of: {sActualMonth}")
								[+] else
									[ ] ReportStatus("Verify Create Average Budget with Rollover option 'Roll over only positive balances at the end of each month' in Graph view" ,FAIL, "The category budget values for category: {sCategory} for 'Roll over only positive balances at the end of each month' in Graph view is NOT as expected: {iAmount} for the month of: {sActualMonth}")
								[ ] ///Go to next month
								[+] if (iCounter < iRemainingMonths)
									[ ] MDIClient.Budget.ForwardMonthButton.Click()
								[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify that User is able to launch the calculate average budget using gear option associated with category."  , FAIL,"Calculte Average Budget didn't appear using gear option associated with category on Graph View.")
						[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify budget gets added.", FAIL, "Budget: {sBudgetName} couldn't be added.")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify budget gets deleted.", FAIL, "Budget: {sBudgetName} couldn't be deleted.")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
	[ ] 
[ ] 
[ ] 
[+] //##########Test 155C: Verify Calculate Average Budget with Rollover option 'Roll over only positive balances at the end of each month' from gear icon on Annual View. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test155C_VerifyCalculateAverageBudgetWithRolloverAtTheEndOfTheMonthFromGearIconInAnnualView
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify the functionality of Calculate Average Budget with Rollover option 'Roll over only positive balances at the end of each month' from gear icon on Annual View
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If functionality of Calculate Average Budget with Rollover option 'Roll over only positive balances at the end of each month' from gear icon in Annual view is as expected
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  July 29 2014
	[ ] // ********************************************************
[ ] 
[+] testcase Test155C_VerifyCalculateAverageBudgetWithRolloverAtTheEndOfTheMonthFromGearIconInAnnualView() appstate none
	[ ] 
	[+] //--------------Variable Declaration------------
		[ ] 
		[ ] STRING sActualYear , sRemainingMonthsAmountPattern ,sLeftOver
		[ ] BOOLEAN bMatch=FALSE
		[ ] iBudgetAmount=50
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] lsCategoryList=lsExcelData[1]
		[ ] sCategory=lsCategoryList[3]
		[ ] // Fetch 1st row from sRegTransactionSheet the given sheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sRegTransactionSheet)
		[ ] lsTransaction=lsExcelData[1]
		[ ] iTxnAmount=VAL(lsTransaction[3])
		[ ] 
		[ ] sCurrentMonth=FormatDateTime(GetDateTime(), "m") //Get current month as January 2014
		[ ] iCurrentMonth = VAL(sCurrentMonth)
		[ ] sCurrentYear=FormatDateTime(GetDateTime(),"yyyy")
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
		[+] if (iResult==PASS)
			[ ] sleep(2)
			[ ] iResult=DeleteBudget()
			[+] if (iResult==PASS)
				[ ] iResult=AddBudget(sBudgetName)
				[+] if (iResult==PASS)
					[ ] ReportStatus("Verify budget gets added.", PASS, "Budget: {sBudgetName} has been added.")
					[ ] 
					[ ] QuickenWindow.SetActive()
					[ ] 
					[ ] 
					[ ] //// Set Parent rollup on annual view
					[ ] SelectBudgetOptionOnGraphAnnualView(sAnnualView,"Rollup")
					[ ] sleep(2)
					[ ] SelectDeselectGearMenuOptions(sCategory , sCalculateAverageBudget ,FALSE )
					[+] if(DlgCalculateAverageBudget.Exists(5))
						[ ] DlgCalculateAverageBudget.SetActive()
						[ ] DlgCalculateAverageBudget.BudgetTextField.SetText(Str(iBudgetAmount))
						[ ] DlgCalculateAverageBudget.ApplyComboBox.Select("to all of 201*")
						[ ] DlgCalculateAverageBudget.SetActive()
						[ ] //Enable Rollover option 'Roll over only positive balances at the end of each month'
						[ ] DlgCalculateAverageBudget.RolloverOptionsButton.Click()
						[ ] sleep(1)
						[ ] DlgCalculateAverageBudget.TypeKeys(replicate(KEY_DN,2))
						[ ] sleep(0.5)
						[ ] DlgCalculateAverageBudget.TypeKeys(KEY_ENTER)
						[ ] 
						[ ] 
						[ ] DlgCalculateAverageBudget.OKButton.Click()
						[ ] WaitForState(DlgCalculateAverageBudget , False , 5)
						[ ] 
						[ ] QuickenWindow.SetActive()
						[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sAnnualView) 
						[ ] sleep(2)
						[ ] 
						[ ] ////Select annual view on budget
						[ ] lsRolloverData = CreateRollOverData(  sCategory, iBudgetAmount ,  iTxnAmount)
						[ ] sExpectedNoTxnRollOverAmount =lsRolloverData[2]
						[ ] sExpectedTxnRollOverAmount =lsRolloverData[3]
						[ ] iCatTotalRolloverAmount=lsRolloverData[1]
						[ ] 
						[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sAnnualView)
						[ ] sleep(4)
						[ ] QuickenWindow.SetActive()
						[ ] MDIClient.Budget.AnnualViewTypeComboBox.Select("Balance only")
						[ ] sleep(2)
						[ ] QuickenWindow.SetActive()
						[+] if (MDIClient.Budget.ShowBalanceInFutureMonthsCheckBox.Exists(2))
							[ ] MDIClient.Budget.ShowBalanceInFutureMonthsCheckBox.Check()
							[ ] 
						[ ] 
						[ ] 
						[ ] sExpectedPattern ="*{sExpectedNoTxnRollOverAmount}*{sExpectedTxnRollOverAmount}*{iCatTotalRolloverAmount}*"
						[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
						[ ] iListCount= MDIClient.Budget.ListBox.GetItemCount() +1
						[+] for (iCount=2 ; iCount<=iListCount;++iCount)
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
							[ ] bMatch = MatchStr(sExpectedPattern, StrTran(sActual,",",""))
							[+] if (bMatch)
								[ ] break
						[+] if(bMatch)
							[ ] ReportStatus("Verify Create Average Budget with Rollover option 'Roll Over balances at the end of each month' in Annual view" ,PASS, "The category budget values for category: {sCategory} for 'Roll Over balances at the end of each month' in Annual view expected: {sExpectedPattern}")
						[+] else
							[ ] ReportStatus("Verify Create Average Budget with Rollover option 'Roll Over balances at the end of each month' in Annual view" ,FAIL, "The category budget values for category: {sCategory} for 'Roll Over balances at the end of each month' in Annual view is NOT as expected: {sExpectedPattern}")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify that User is able to launch the calculate average budget using gear option associated with category."  , FAIL,"Calculte Average Budget didn't appear using gear option associated with category on Graph View.")
						[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify budget gets added.", FAIL, "Budget: {sBudgetName} couldn't be added.")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify budget gets deleted.", FAIL, "Budget: {sBudgetName} couldn't be deleted.")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
	[ ] 
[ ] 
[+] //##########Test 155D: Verify Calculate Average Budget with Rollover option 'Roll over only positive balances at the end of each month' from gear icon on Annual View. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test155D_VerifyCalculateAverageBudgetWithRolloverOnlyPositiveBalancesGearIconInAnnualView
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify the functionality of Calculate Average Budget with Rollover option 'Roll over only positive balances at the end of each month' from gear icon on Annual View
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If functionality of Calculate Average Budget with Rollover option 'Roll over only positive balances at the end of each month' from gear icon in Annual view is as expected
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  July 28 2014
	[ ] // ********************************************************
[ ] 
[+] testcase Test155D_VerifyCalculateAverageBudgetWithRolloverOnlyPositiveBalancesGearIconInAnnualView() appstate none
	[ ] 
	[+] //--------------Variable Declaration------------
		[ ] 
		[ ] STRING sActualYear , sRemainingMonthsAmountPattern ,sLeftOver
		[ ] BOOLEAN bMatch=FALSE
		[ ] iBudgetAmount=50
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] lsCategoryList=lsExcelData[1]
		[ ] sCategory=lsCategoryList[3]
		[ ] // Fetch 1st row from sRegTransactionSheet the given sheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sRegTransactionSheet)
		[ ] lsTransaction=lsExcelData[1]
		[ ] iTxnAmount=VAL(lsTransaction[3])
		[ ] 
		[ ] sCurrentMonth=FormatDateTime(GetDateTime(), "m") //Get current month as January 2014
		[ ] iCurrentMonth = VAL(sCurrentMonth)
		[ ] sCurrentYear=FormatDateTime(GetDateTime(),"yyyy")
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
		[+] if (iResult==PASS)
			[ ] sleep(2)
			[ ] iResult=DeleteBudget()
			[+] if (iResult==PASS)
				[ ] iResult=AddBudget(sBudgetName)
				[+] if (iResult==PASS)
					[ ] ReportStatus("Verify budget gets added.", PASS, "Budget: {sBudgetName} has been added.")
					[ ] 
					[ ] QuickenWindow.SetActive()
					[ ] 
					[ ] 
					[ ] //// Set Parent rollup on annual view
					[ ] SelectBudgetOptionOnGraphAnnualView(sAnnualView,"Rollup")
					[ ] sleep(2)
					[ ] SelectDeselectGearMenuOptions(sCategory , sCalculateAverageBudget ,FALSE )
					[+] if(DlgCalculateAverageBudget.Exists(5))
						[ ] DlgCalculateAverageBudget.SetActive()
						[ ] DlgCalculateAverageBudget.BudgetTextField.SetText(Str(iBudgetAmount))
						[ ] DlgCalculateAverageBudget.ApplyComboBox.Select("to all of 201*")
						[ ] DlgCalculateAverageBudget.SetActive()
						[ ] //Enable Rollover option 'Roll over only positive balances at the end of each month'
						[ ] DlgCalculateAverageBudget.RolloverOptionsButton.Click()
						[ ] sleep(1)
						[ ] DlgCalculateAverageBudget.TypeKeys(replicate(KEY_DN,3))
						[ ] sleep(0.5)
						[ ] DlgCalculateAverageBudget.TypeKeys(KEY_ENTER)
						[ ] 
						[ ] 
						[ ] DlgCalculateAverageBudget.OKButton.Click()
						[ ] WaitForState(DlgCalculateAverageBudget , False , 5)
						[ ] 
						[ ] QuickenWindow.SetActive()
						[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sAnnualView) 
						[ ] sleep(2)
						[ ] MDIClient.Budget.AnnualViewTypeComboBox.Select("Balance only")
						[ ] sleep(2)
						[+] if (MDIClient.Budget.ShowBalanceInFutureMonthsCheckBox.Exists(2))
							[ ] MDIClient.Budget.ShowBalanceInFutureMonthsCheckBox.Check()
							[ ] 
						[ ] 
						[ ] 
						[+] ///Create only positive balances rollover data
							[ ] iTxnMonthCount=4
							[ ] iRollOverWithNoTxnMonthAmount=0
							[ ] iRemainingMonths=12 - iCurrentMonth
							[ ] iRemainingMonthsAmount=iRemainingMonths*iBudgetAmount
							[+] if (iRemainingMonthsAmount<0)
								[ ] iRemainingMonthsAmount=0
							[ ] 
							[+] if (iCurrentMonth>4)
								[ ] iRollOverWithNoTxnMonthCount=iCurrentMonth-4
								[ ] iTxnMonthCount=4
							[+] else
								[ ] iTxnMonthCount= iCurrentMonth
								[ ] iRollOverWithNoTxnMonthCount=0
								[ ] 
							[ ] 
							[ ] 
							[ ] 
							[+] if (iTxnMonthCount>1)
								[ ] 
								[ ] ///Get rollover amounts for months for whom there are no transactions
								[+] if (iRollOverWithNoTxnMonthCount > 0)
									[ ] iExpectedNoTxnRollOverAmount=iBudgetAmount
									[ ] sExpectedNoTxnRollOverAmount="@{iExpectedNoTxnRollOverAmount}@"
									[+] for (iCount=2; iCount<=iRollOverWithNoTxnMonthCount; iCount++)
										[ ] sExpectedNoTxnRollOverAmount =sExpectedNoTxnRollOverAmount +"{iBudgetAmount+iExpectedNoTxnRollOverAmount}@"
										[ ] iExpectedNoTxnRollOverAmount=iBudgetAmount+iExpectedNoTxnRollOverAmount
								[+] else
									[ ] sExpectedNoTxnRollOverAmount=""
									[ ] iExpectedNoTxnRollOverAmount=0
								[ ] ///Get rollover amounts for months for whom there are  transactions
								[ ] iDiffOfBudgetTxnAmount= iBudgetAmount-iTxnAmount
								[ ] iExpectedTxnRollOverAmount=iExpectedNoTxnRollOverAmount+iDiffOfBudgetTxnAmount
								[ ] sExpectedTxnRollOverAmount="@{str(iExpectedTxnRollOverAmount)}@"
								[+] for (iCount=2; iCount<=iTxnMonthCount; iCount++)
									[ ] 
									[+] if (iExpectedTxnRollOverAmount>0)
										[ ] iExpectedTxnRollOverAmount= iDiffOfBudgetTxnAmount+iExpectedTxnRollOverAmount
									[+] else
										[ ] iExpectedTxnRollOverAmount= iDiffOfBudgetTxnAmount
									[ ] sExpectedTxnRollOverAmount =sExpectedTxnRollOverAmount +"{iExpectedTxnRollOverAmount}@"
									[ ] 
									[ ] 
									[ ] 
								[ ] 
								[+] if (iExpectedTxnRollOverAmount<0)
									[ ] iExpectedTxnRollOverAmount=0
								[ ] iTotalRolloverAmount=iExpectedTxnRollOverAmount+iRemainingMonthsAmount
							[+] else
								[ ] iExpectedNoTxnRollOverAmount=0
								[ ] iExpectedTxnRollOverAmount=0
								[ ] sExpectedNoTxnRollOverAmount="0"
								[ ] sExpectedTxnRollOverAmount="0"
						[ ] 
						[ ] 
						[ ] ///remaining months pattern
						[ ] iAmount=iBudgetAmount
						[ ] sRemainingMonthsAmountPattern="@{iBudgetAmount}@" 
						[+] for (iCount=2 ; iCount<=iRemainingMonths;++iCount)
							[ ] iAmount=iAmount+iBudgetAmount
							[ ] sRemainingMonthsAmountPattern=sRemainingMonthsAmountPattern +"{iAmount}@"
						[ ] ///monthly budget expected pattern {sRemainingMonthsAmountPattern}
						[ ] sExpectedPattern="{sExpectedNoTxnRollOverAmount}{sExpectedTxnRollOverAmount}*{sRemainingMonthsAmountPattern}{iTotalRolloverAmount}*"
						[ ] sExpectedPattern=StrTran( sExpectedPattern, "@@","@")
						[ ] 
						[ ] ///Verify that budget has been extended as expected.
						[ ] //
						[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
						[ ] iListCount= MDIClient.Budget.ListBox.GetItemCount() +1
						[ ] 
						[ ] sActualYear=MDIClient.Budget.CurrentMonthStaticText.GetText()
						[+] for (iCount=3 ; iCount<=iListCount;++iCount)
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
							[+] // Manipulate sActual to remove extraneous characters otherwise pattern won't match
								[ ] sActual=StrTran( sActual, "<af href=Actual>","")
								[ ] 
								[ ] sActual=StrTran( sActual, "</a>","")
								[ ] sActual=StrTran( sActual, "@@","@")
								[ ] sActual=StrTran( sActual, "@@","@")
								[ ] sActual=StrTran( sActual, "<font style=","")
								[ ] sActual=StrTran( sActual, "color:#ff0000","")
								[ ] sActual=StrTran( sActual, "</font>","")
								[ ] sActual=StrTran( sActual, ">","")
								[ ] 
								[ ] sActual=StrTran( sActual,chr(34),"")
								[ ] 
							[ ] 
							[ ] bMatch = MatchStr(sExpectedPattern, StrTran(sActual,",",""))
							[+] if (bMatch)
								[ ] break
						[+] if(bMatch)
							[ ] ReportStatus("Verify Create Average Budget with Rollover option 'Roll over only positive balances at the end of each month' in Annual view" ,PASS, "The category budget values for category: {sCategory} for 'Roll over only positive balances at the end of each month' in Annual view expected: {sExpectedPattern}")
						[+] else
							[ ] ReportStatus("Verify Create Average Budget with Rollover option 'Roll over only positive balances at the end of each month' in Annual view" ,FAIL, "The category budget values for category: {sCategory} for 'Roll over only positive balances at the end of each month' in Annual view is NOT as expected: {sExpectedPattern}")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify that User is able to launch the calculate average budget using gear option associated with category."  , FAIL,"Calculte Average Budget didn't appear using gear option associated with category on Graph View.")
						[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify budget gets added.", FAIL, "Budget: {sBudgetName} couldn't be added.")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify budget gets deleted.", FAIL, "Budget: {sBudgetName} couldn't be deleted.")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
	[ ] 
[ ] 
[+] //##########Test 109: Verify the functionality of rollover reset from either the graph or Annual view. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test109_VerifyTheFunctionalityOfRolloverResetFromGraphOrAnnualView
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify the functionality of rollover reset from either the graph or Annual view
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If the functionality of rollover reset from either the graph or Annual view is correct
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  Aug 4 2014
	[ ] // ********************************************************
[ ] 
[+] testcase Test109_VerifyTheFunctionalityOfRolloverResetFromGraphOrAnnualView() appstate none
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] LIST OF STRING lsExpectedTxnRollOverAmount
		[ ] STRING  sCurrentMonthRolloverAmount
		[ ] INTEGER iGraphViewRolloverEditAmount , iAnnualViewRolloverEditAmount
		[ ] iGraphViewRolloverEditAmount=300
		[ ] iAnnualViewRolloverEditAmount=400
		[ ] sBudgetName = "BudgetTest"
		[ ] bMatch=FALSE
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] iBudgetAmount=50
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] lsCategoryList=lsExcelData[1]
		[ ] sCategory=lsCategoryList[3]
		[ ] // Fetch 1st row from sRegTransactionSheet the given sheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sRegTransactionSheet)
		[ ] lsTransaction=lsExcelData[1]
		[ ] iTxnAmount=VAL(lsTransaction[3])
		[ ] 
		[ ] sCurrentMonth=FormatDateTime(GetDateTime(), "m") //Get current month as January 2014
		[ ] iCurrentMonth = VAL(sCurrentMonth)
		[ ] iRollOverMonthCount=4
		[ ] 
		[ ] 
		[ ] //Rollover value calculation
		[ ] lsRolloverData = CreateRollOverData(  sCategory, iBudgetAmount ,  iTxnAmount)
		[ ] sExpectedNoTxnRollOverAmount =lsRolloverData[2]
		[ ] sExpectedTxnRollOverAmount =lsRolloverData[3]
		[ ] iCatTotalRolloverAmount=lsRolloverData[1]
		[ ] 
		[ ] sExpectedTxnRollOverAmount= StrTran(sExpectedTxnRollOverAmount , "**" ,"*")
		[ ] lsExpectedTxnRollOverAmount = split(sExpectedTxnRollOverAmount ,"*")
		[ ] sCurrentMonthRolloverAmount = trim(lsExpectedTxnRollOverAmount[5])
		[ ] 
		[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
		[+] if (iResult==PASS)
			[ ] sleep(2)
			[ ] iResult=DeleteBudget()
			[+] if (iResult==PASS)
				[ ] iResult=AddBudget(sBudgetName)
				[+] if (iResult==PASS)
					[ ] ReportStatus("Verify budget gets added.", PASS, "Budget: {sBudgetName} has been added.")
					[ ] 
					[ ] QuickenWindow.SetActive()
					[ ] 
					[ ] 
					[ ] //// Set Parent rollup on
					[ ] SelectBudgetOptionOnGraphAnnualView(sGraphView,"Rollup")
					[ ] sleep(2)
					[ ] iResult=AddAverageBudget(sCategory ,iBudgetAmount)
					[+] if (iResult==PASS)
						[ ] QuickenWindow.SetActive()
						[ ] QuickenWindow.Restore()
						[ ] ///Enable Rollover 
						[ ] SelectDeselectRollOverOptions (sCategory, sSetRollOverBalance,TRUE)
						[ ] sleep(2)
						[ ] QuickenWindow.SetActive()
						[ ] 
						[ ] //Verify rollover editing on Graph View
						[ ] 
						[ ] //Click on the rollover amount associated with category
						[ ] MDIClient.Budget.ListBox.TextClick(sCurrentMonthRolloverAmount ,3)
						[ ] 
						[+] if (RolloverCalloutPopup.Exists(5))
							[ ] ReportStatus("Verify Rollover reset dialog appeared." , PASS , "Rollover reset dialog appeared.")
							[ ] 
							[ ] //click on the edit button
							[ ] RolloverCalloutPopup.EditResetButton.Click()
							[+] if (RolloverCalloutPopup.RolloverAmountTextField.Exists(5))
								[ ] RolloverCalloutPopup.RolloverAmountTextField.SetText(Str(iGraphViewRolloverEditAmount))
								[ ] RolloverCalloutPopup.SaveButton.Click()
								[ ] WaitForState(RolloverCalloutPopup , False, 2)
								[ ] 
								[ ] //Calculate the updated rollover
								[ ] sCurrentMonthRolloverAmount=NULL
								[ ] sCurrentMonthRolloverAmount=STR((iGraphViewRolloverEditAmount+iBudgetAmount) - ( iTxnAmount))
								[ ] 
								[ ] QuickenWindow.SetActive()
								[ ] //Verfiy that rollover amount has been updated on graph view
								[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
								[ ] iListCount= MDIClient.Budget.ListBox.GetItemCount() +1
								[ ] 
								[+] for (iCount=1 ; iCount<=iListCount;++iCount)
									[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
									[ ] 
									[ ] bMatch = MatchStr("*{sCategory}*{sCurrentMonthRolloverAmount}*", StrTran(sActual,",",""))
									[+] if (bMatch)
										[ ] break
								[+] if(bMatch)
									[ ] ReportStatus("Verfiy that rollover amount has been updated on Graph View" ,PASS, "The rollover amount for category: {sCategory} for 'Roll over at the end of each month' in graph view is updated as expected: {sCurrentMonthRolloverAmount}")
								[+] else
									[ ] ReportStatus("Verfiy that rollover amount has been updated on Graph View" ,FAIL, "The rollover amount for category: {sCategory} for 'Roll over at the end of each month' in graph view didn't update as expected: {sCurrentMonthRolloverAmount}")
							[+] else
								[ ] ReportStatus("Verify Rollover reset amount textfield enabled after clicking on Edit button." , FAIL , "Rollover reset amount textfield didn't get enable after clicking on Edit button.")
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Rollover reset dialog appeared." , FAIL , "Rollover reset dialog didn't appear.")
						[ ] 
						[ ] 
						[ ] 
						[ ] //Verify rollover editing on Annual View
						[ ] 
						[ ] //Click on the rollover amount associated with category
						[ ] QuickenWindow.SetActive()
						[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sAnnualView) 
						[ ] sleep(2)
						[ ] MDIClient.Budget.AnnualViewTypeComboBox.Select("Balance only")
						[ ] sleep(2)
						[ ] 
						[ ] MDIClient.Budget.ListBox.TextClick(sCategory)
						[ ] sleep(2)
						[ ] MDIClient.Budget.ListBox.TextClick(sCurrentMonthRolloverAmount ,4)
						[ ] 
						[+] if (RolloverCalloutPopup.Exists(5))
							[ ] ReportStatus("Verify Rollover reset dialog appeared." , PASS , "Rollover reset dialog appeared.")
							[ ] 
							[ ] //click on the edit button
							[ ] RolloverCalloutPopup.EditResetButton.Click()
							[+] if (RolloverCalloutPopup.RolloverAmountTextField.Exists(5))
								[ ] RolloverCalloutPopup.RolloverAmountTextField.SetText(Str(iAnnualViewRolloverEditAmount))
								[ ] RolloverCalloutPopup.SaveButton.Click()
								[ ] WaitForState(RolloverCalloutPopup , False, 2)
								[ ] 
								[ ] //Calculate the updated rollover
								[ ] sCurrentMonthRolloverAmount=NULL
								[ ] sCurrentMonthRolloverAmount=STR((iAnnualViewRolloverEditAmount+iBudgetAmount) - ( iTxnAmount))
								[ ] 
								[ ] QuickenWindow.SetActive()
								[ ] //Verfiy that rollover amount has been updated on graph view
								[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
								[ ] iListCount= MDIClient.Budget.ListBox.GetItemCount() +1
								[ ] 
								[+] for (iCount=1 ; iCount<=iListCount;++iCount)
									[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
									[ ] 
									[ ] bMatch = MatchStr("*{sCurrentMonthRolloverAmount}*", StrTran(sActual,",",""))
									[+] if (bMatch)
										[ ] break
								[+] if(bMatch)
									[ ] ReportStatus("Verfiy that rollover amount has been updated on Annual View" ,PASS, "The rollover amount for category: {sCategory} for 'Roll over at the end of each month' in Annual View is updated as expected: {sCurrentMonthRolloverAmount}")
								[+] else
									[ ] ReportStatus("Verfiy that rollover amount has been updated on Annual View" ,FAIL, "The rollover amount for category: {sCategory} for 'Roll over at the end of each month' in Annual View didn't update as expected: {sCurrentMonthRolloverAmount}")
							[+] else
								[ ] ReportStatus("Verify Rollover reset amount textfield enabled after clicking on Edit button." , FAIL , "Rollover reset amount textfield didn't get enable after clicking on Edit button.")
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Rollover reset dialog appeared." , FAIL , "Rollover reset dialog didn't appear.")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify that User is able to add average budget for category: {sCategory} with amount: {iBudgetAmount}."  , FAIL,"Average budget for category: {sCategory} with amount: {iBudgetAmount} couldn't be added for 12 months on Graph View.")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify budget gets added.", FAIL, "Budget: {sBudgetName} couldn't be added.")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify budget gets deleted.", FAIL, "Budget: {sBudgetName} couldn't be deleted.")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
	[ ] 
[ ] 
[+] //##########Test 110: Verify the functionality of canceling rollover reset from either the graph or Annual view #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test110_VerifyTheCancellingRolloverResetFromGraphOrAnnualView
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify the functionality of canceling rollover reset from either the graph or Annual view 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If  functionality of canceling rollover reset from either the graph or Annual view is correct
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  Aug 5 2014
	[ ] // ********************************************************
[ ] 
[+] testcase Test110_VerifyTheCancellingRolloverResetFromGraphOrAnnualView() appstate none
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] LIST OF STRING lsExpectedTxnRollOverAmount
		[ ] STRING  sOriginalCurrentMonthRolloverAmount  ,sCurrentMonthRolloverAmount
		[ ] INTEGER iGraphViewRolloverEditAmount , iAnnualViewRolloverEditAmount
		[ ] iGraphViewRolloverEditAmount=300
		[ ] iAnnualViewRolloverEditAmount=400
		[ ] sBudgetName = "BudgetTest"
		[ ] bMatch=FALSE
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] iBudgetAmount=50
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] lsCategoryList=lsExcelData[1]
		[ ] sCategory=lsCategoryList[3]
		[ ] // Fetch 1st row from sRegTransactionSheet the given sheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sRegTransactionSheet)
		[ ] lsTransaction=lsExcelData[1]
		[ ] iTxnAmount=VAL(lsTransaction[3])
		[ ] 
		[ ] sCurrentMonth=FormatDateTime(GetDateTime(), "m") //Get current month as January 2014
		[ ] iCurrentMonth = VAL(sCurrentMonth)
		[ ] iRollOverMonthCount=4
		[ ] 
		[ ] 
		[ ] //Rollover value calculation
		[ ] lsRolloverData = CreateRollOverData(  sCategory, iBudgetAmount ,  iTxnAmount)
		[ ] sExpectedNoTxnRollOverAmount =lsRolloverData[2]
		[ ] sExpectedTxnRollOverAmount =lsRolloverData[3]
		[ ] iCatTotalRolloverAmount=lsRolloverData[1]
		[ ] 
		[ ] sExpectedTxnRollOverAmount= StrTran(sExpectedTxnRollOverAmount , "**" ,"*")
		[ ] lsExpectedTxnRollOverAmount = split(sExpectedTxnRollOverAmount ,"*")
		[ ] sOriginalCurrentMonthRolloverAmount = trim(lsExpectedTxnRollOverAmount[5])
		[ ] 
		[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
		[+] if (iResult==PASS)
			[ ] sleep(2)
			[ ] iResult=DeleteBudget()
			[+] if (iResult==PASS)
				[ ] iResult=AddBudget(sBudgetName)
				[+] if (iResult==PASS)
					[ ] ReportStatus("Verify budget gets added.", PASS, "Budget: {sBudgetName} has been added.")
					[ ] 
					[ ] QuickenWindow.SetActive()
					[ ] 
					[ ] 
					[ ] //// Set Parent rollup on
					[ ] SelectBudgetOptionOnGraphAnnualView(sGraphView,"Rollup")
					[ ] sleep(2)
					[ ] iResult=AddAverageBudget(sCategory ,iBudgetAmount)
					[+] if (iResult==PASS)
						[ ] QuickenWindow.SetActive()
						[ ] ///Enable Rollover 
						[ ] 
						[ ] SelectDeselectRollOverOptions (sCategory, sSetRollOverBalance,TRUE)
						[ ] sleep(2)
						[ ] QuickenWindow.SetActive()
						[ ] 
						[ ] //Verify rollover editing on Graph View
						[ ] 
						[ ] //Click on the rollover amount associated with category
						[ ] MDIClient.Budget.ListBox.TextClick(sOriginalCurrentMonthRolloverAmount ,3)
						[ ] 
						[+] if (RolloverCalloutPopup.Exists(5))
							[ ] ReportStatus("Verify Rollover reset dialog appeared." , PASS , "Rollover reset dialog appeared.")
							[ ] 
							[ ] //click on the edit button
							[ ] RolloverCalloutPopup.EditResetButton.Click()
							[+] if (RolloverCalloutPopup.RolloverAmountTextField.Exists(5))
								[ ] RolloverCalloutPopup.RolloverAmountTextField.SetText(Str(iGraphViewRolloverEditAmount))
								[ ] RolloverCalloutPopup.SaveButton.Click()
								[ ] WaitForState(RolloverCalloutPopup , False, 2)
								[ ] 
								[ ] //Calculate the updated rollover
								[ ] sCurrentMonthRolloverAmount=NULL
								[ ] sCurrentMonthRolloverAmount=STR((iGraphViewRolloverEditAmount+iBudgetAmount) - ( iTxnAmount))
								[ ] 
								[ ] QuickenWindow.SetActive()
								[ ] //Verfiy that rollover amount has been updated on graph view
								[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
								[ ] iListCount= MDIClient.Budget.ListBox.GetItemCount() +1
								[ ] 
								[+] for (iCount=1 ; iCount<=iListCount;++iCount)
									[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
									[ ] 
									[ ] bMatch = MatchStr("*{sCategory}*{sCurrentMonthRolloverAmount}*", StrTran(sActual,",",""))
									[+] if (bMatch)
										[ ] break
								[+] if(bMatch)
									[ ] ReportStatus("Verfiy that rollover amount has been updated on Graph View" ,PASS, "The rollover amount for category: {sCategory} for 'Roll over at the end of each month' in graph view is updated as expected: {sCurrentMonthRolloverAmount}")
								[+] else
									[ ] ReportStatus("Verfiy that rollover amount has been updated on Graph View" ,FAIL, "The rollover amount for category: {sCategory} for 'Roll over at the end of each month' in graph view didn't update as expected: {sCurrentMonthRolloverAmount}")
								[ ] 
								[ ] ////Apply 'Undo all rollover edits for year 2014 (set to default)' option on Graph View
								[ ] SelectDeselectRollOverOptions (sCategory, sUndoAllRolloverEdits,TRUE)
								[ ] 
								[ ] ////Verify applying 'Undo all rollover edits for year 2014 (set to default)' resets the rollover value to original values on Graph View
								[+] for (iCount=1 ; iCount<=iListCount;++iCount)
									[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
									[ ] 
									[ ] bMatch = MatchStr("*{sCategory}*{sOriginalCurrentMonthRolloverAmount}*", StrTran(sActual,",",""))
									[+] if (bMatch)
										[ ] break
								[+] if(bMatch)
									[ ] ReportStatus("Verify applying 'Undo all rollover edits for year 2014 (set to default)' resets the rollover value to original values on Graph View" ,PASS, "The rollover for category: {sCategory} has been reset to original values: {sOriginalCurrentMonthRolloverAmount}.")
								[+] else
									[ ] ReportStatus("Verify applying 'Undo all rollover edits for year 2014 (set to default)' resets the rollover value to original values on Graph View" ,FAIL, "The rollover for category: {sCategory} couldn't be reset to original values: {sOriginalCurrentMonthRolloverAmount}.")
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Rollover reset amount textfield enabled after clicking on Edit button." , FAIL , "Rollover reset amount textfield didn't get enable after clicking on Edit button.")
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Rollover reset dialog appeared." , FAIL , "Rollover reset dialog didn't appear.")
						[ ] 
						[ ] 
						[ ] 
						[ ] //Verify rollover editing on Annual View
						[ ] 
						[ ] //Click on the rollover amount associated with category
						[ ] QuickenWindow.SetActive()
						[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sAnnualView) 
						[ ] sleep(2)
						[ ] MDIClient.Budget.AnnualViewTypeComboBox.Select("Balance only")
						[ ] sleep(2)
						[ ] 
						[ ] 
						[ ] MDIClient.Budget.ListBox.TextClick(sCategory)
						[ ] sleep(5)
						[ ] MDIClient.Budget.ListBox.TextClick(sOriginalCurrentMonthRolloverAmount ,5)
						[ ] 
						[+] if (RolloverCalloutPopup.Exists(5))
							[ ] ReportStatus("Verify Rollover reset dialog appeared." , PASS , "Rollover reset dialog appeared.")
							[ ] 
							[ ] //click on the edit button
							[ ] RolloverCalloutPopup.EditResetButton.Click()
							[+] if (RolloverCalloutPopup.RolloverAmountTextField.Exists(5))
								[ ] RolloverCalloutPopup.RolloverAmountTextField.SetText(Str(iAnnualViewRolloverEditAmount))
								[ ] RolloverCalloutPopup.SaveButton.Click()
								[ ] WaitForState(RolloverCalloutPopup , False, 2)
								[ ] 
								[ ] //Calculate the updated rollover
								[ ] sCurrentMonthRolloverAmount=NULL
								[ ] sCurrentMonthRolloverAmount=STR((iAnnualViewRolloverEditAmount+iBudgetAmount) - ( iTxnAmount))
								[ ] 
								[ ] QuickenWindow.SetActive()
								[ ] //Verfiy that rollover amount has been updated on graph view
								[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
								[ ] iListCount= MDIClient.Budget.ListBox.GetItemCount() +1
								[ ] 
								[+] for (iCount=1 ; iCount<=iListCount;++iCount)
									[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
									[ ] 
									[ ] bMatch = MatchStr("*{sCurrentMonthRolloverAmount}*", StrTran(sActual,",",""))
									[+] if (bMatch)
										[ ] break
								[+] if(bMatch)
									[ ] ReportStatus("Verfiy that rollover amount has been updated on Annual View" ,PASS, "The rollover amount for category: {sCategory} for 'Roll over at the end of each month' in Annual View is updated as expected: {sCurrentMonthRolloverAmount}")
								[+] else
									[ ] ReportStatus("Verfiy that rollover amount has been updated on Annual View" ,FAIL, "The rollover amount for category: {sCategory} for 'Roll over at the end of each month' in Annual View didn't update as expected: {sCurrentMonthRolloverAmount}")
								[ ] 
								[ ] 
								[ ] 
								[ ] ////Apply 'Undo all rollover edits for year 2014 (set to default)' option on Annual View
								[ ] SelectDeselectRollOverOptions (sCategory, sUndoAllRolloverEdits,FALSE)
								[ ] MDIClient.Budget.AnnualViewTypeComboBox.Select("Balance only")
								[ ] sleep(2)
								[ ] 
								[ ] ////Verify applying 'Undo all rollover edits for year 2014 (set to default)' resets the rollover value to original values on Annual View
								[+] for (iCount=1 ; iCount<=iListCount;++iCount)
									[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
									[ ] 
									[ ] bMatch = MatchStr("*{sOriginalCurrentMonthRolloverAmount}*", StrTran(sActual,",",""))
									[+] if (bMatch)
										[ ] break
								[+] if(bMatch)
									[ ] ReportStatus("Verify applying 'Undo all rollover edits for year 2014 (set to default)' resets the rollover value to original values on Annual View" ,PASS, "The rollover for category: {sCategory} has been reset to original values: {sOriginalCurrentMonthRolloverAmount} on Annual View.")
								[+] else
									[ ] ReportStatus("Verify applying 'Undo all rollover edits for year 2014 (set to default)' resets the rollover value to original values on Annual View" ,FAIL, "The rollover for category: {sCategory} couldn't be reset to original values: {sOriginalCurrentMonthRolloverAmount} on Annual View.")
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Rollover reset amount textfield enabled after clicking on Edit button." , FAIL , "Rollover reset amount textfield didn't get enable after clicking on Edit button.")
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Rollover reset dialog appeared." , FAIL , "Rollover reset dialog didn't appear.")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify that User is able to add average budget for category: {sCategory} with amount: {iBudgetAmount}."  , FAIL,"Average budget for category: {sCategory} with amount: {iBudgetAmount} couldn't be added for 12 months on Graph View.")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify budget gets added.", FAIL, "Budget: {sBudgetName} couldn't be added.")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify budget gets deleted.", FAIL, "Budget: {sBudgetName} couldn't be deleted.")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
	[ ] 
[ ] 
[+] //##########Test 110A: Verify the functionality of canceling rollover reset from either the graph or Annual view for Future Year #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test110A_VerifyTheCancellingRolloverResetForFutureYearFromAnnualView
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify the functionality of canceling rollover reset from either the graph or Annual view for Future Year
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If  functionality of canceling rollover reset from either the graph or Annual view for Future Year is correct
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  Aug 7 2014
	[ ] // ********************************************************
[ ] 
[+] testcase Test110A_VerifyTheCancellingRolloverResetForFutureYearFromAnnualView() appstate none
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] LIST OF STRING lsExpectedTxnRollOverAmount 
		[ ] STRING  sOriginalCurrentMonthRolloverAmount  ,sCurrentMonthRolloverAmount,sFutureYear
		[ ] INTEGER  iFutureYearRolloverEditAmount ,iTotalFutureYearBudget ,iFutureCatTotalRolloverAmount
		[ ] iFutureYearRolloverEditAmount=300
		[ ] sBudgetName = "BudgetTest"
		[ ] bMatch=FALSE
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] iBudgetAmount=50
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] lsCategoryList=lsExcelData[1]
		[ ] //delete category type 
		[ ] ListDelete(lsCategoryList ,1)
		[ ] //delete parent category 
		[ ] ListDelete(lsCategoryList ,1)
		[ ] 
		[ ] sCategory=lsCategoryList[1]
		[ ] // Fetch 1st row from sRegTransactionSheet the given sheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sRegTransactionSheet)
		[ ] lsTransaction=lsExcelData[1]
		[ ] iTxnAmount=VAL(lsTransaction[3])
		[ ] 
		[ ] 
		[ ] //Remove null from category list
		[+] for( iCounter=1; iCounter <=ListCount (lsCategoryList) ; iCounter++)
			[+] if (lsCategoryList[iCounter]==NULL)
				[ ] ListDelete (lsCategoryList ,iCounter)
				[ ] iCounter--
				[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] sCurrentMonth=FormatDateTime(GetDateTime(), "m") //Get current month as January 2014
		[ ] iCurrentMonth = VAL(sCurrentMonth)
		[ ] iRollOverMonthCount=4
		[ ] 
		[ ] 
		[ ] //Rollover value calculation
		[ ] lsRolloverData = CreateRollOverData(  sCategory, iBudgetAmount ,  iTxnAmount)
		[ ] sExpectedNoTxnRollOverAmount =lsRolloverData[2]
		[ ] sExpectedTxnRollOverAmount =lsRolloverData[3]
		[ ] iCatTotalRolloverAmount=lsRolloverData[1]
		[ ] 
		[ ] 
		[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
		[+] if (iResult==PASS)
			[ ] sleep(2)
			[ ] iResult=DeleteBudget()
			[+] if (iResult==PASS)
				[ ] iResult=AddBudget(sBudgetName)
				[+] if (iResult==PASS)
					[ ] ReportStatus("Verify budget gets added.", PASS, "Budget: {sBudgetName} has been added.")
					[ ] 
					[ ] QuickenWindow.SetActive()
					[ ] 
					[ ] 
					[ ] //// Set Parent rollup on
					[ ] SelectBudgetOptionOnGraphAnnualView(sGraphView,"Rollup")
					[ ] sleep(2)
					[ ] 
					[ ] //set average budget as zero for two other categories to make textclick on the rollover category specific
					[ ] QuickenWindow.SetActive()
					[ ] AddAverageBudget(lsCategoryList[2] ,0)
					[ ] sleep(2)
					[ ] QuickenWindow.SetActive()
					[ ] AddAverageBudget(lsCategoryList[3] ,0)
					[ ] sleep(2)
					[ ] QuickenWindow.SetActive()
					[ ] iResult=AddAverageBudget(sCategory ,iBudgetAmount)
					[+] if (iResult==PASS)
						[ ] QuickenWindow.SetActive()
						[ ] ///Enable Rollover 
						[ ] 
						[ ] SelectDeselectRollOverOptions (sCategory, sSetRollOverBalance,False)
						[ ] 
						[ ] //Verify rollover editing on Annual View
						[ ] 
						[ ] QuickenWindow.SetActive()
						[ ] MDIClient.Budget.ForwardMonthButton.Click()
						[ ] ///Extend budget for next year using second option
						[+] if (DlgAddABudgetForNextOrPreviousYear.Exists(5))
							[ ] DlgAddABudgetForNextOrPreviousYear.SetActive()
							[ ] sActual =DlgAddABudgetForNextOrPreviousYear.GetProperty("Caption")
							[ ] DlgAddABudgetForNextOrPreviousYear.RadioListCopyThisYearsCategoriesAndActualsAsBudget.Select(1)
							[ ] DlgAddABudgetForNextOrPreviousYear.OKButton.Click()
							[ ] sleep(3)
							[ ] QuickenWindow.SetActive()
							[ ] MDIClient.Budget.AnnualViewTypeComboBox.Select("Balance only")
							[ ] sleep(2)
							[ ] sFutureYear =MDIClient.Budget.CurrentMonthStaticText.GetText()
							[ ] QuickenWindow.SetActive()
							[+] if (MDIClient.Budget.ShowBalanceInFutureMonthsCheckBox.Exists(2))
								[ ] MDIClient.Budget.ShowBalanceInFutureMonthsCheckBox.Check()
								[ ] 
							[ ] sleep(2)
							[ ] ///Calculate future year budget
							[ ] iTotalFutureYearBudget =iCurrentMonth*iBudgetAmount
							[ ] ///monthly budget expected pattern
							[ ] iFutureCatTotalRolloverAmount=iCatTotalRolloverAmount +iTotalFutureYearBudget
							[ ] 
							[ ] QuickenWindow.SetActive()
							[ ] MDIClient.Budget.ListBox.TextClick(sCategory)
							[ ] sleep(5)
							[ ] MDIClient.Budget.ListBox.TextClick(Str(iFutureCatTotalRolloverAmount) ,3)
							[ ] 
							[+] if (RolloverCalloutPopup.Exists(5))
								[ ] ReportStatus("Verify Rollover reset dialog appeared." , PASS , "Rollover reset dialog appeared.")
								[ ] 
								[ ] //click on the edit button
								[ ] RolloverCalloutPopup.EditResetButton.Click()
								[+] if (RolloverCalloutPopup.RolloverAmountTextField.Exists(5))
									[ ] RolloverCalloutPopup.RolloverAmountTextField.SetText(Str(iFutureYearRolloverEditAmount))
									[ ] RolloverCalloutPopup.SaveButton.Click()
									[ ] WaitForState(RolloverCalloutPopup , False, 2)
									[ ] 
									[ ] //Calculate the updated rollover
									[ ] sCurrentMonthRolloverAmount=NULL
									[ ] sCurrentMonthRolloverAmount=STR(iFutureYearRolloverEditAmount+iBudgetAmount) 
									[ ] 
									[ ] QuickenWindow.SetActive()
									[ ] //Verfiy that rollover amount has been updated on graph view
									[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
									[ ] iListCount= MDIClient.Budget.ListBox.GetItemCount() +1
									[ ] 
									[+] for (iCount=1 ; iCount<=iListCount;++iCount)
										[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
										[ ] 
										[ ] bMatch = MatchStr("*{sCurrentMonthRolloverAmount}*", StrTran(sActual,",",""))
										[+] if (bMatch)
											[ ] break
									[+] if(bMatch)
										[ ] ReportStatus("Verfiy that rollover amount has been updated on Annual View for future year: {sFutureYear}." ,PASS, "The rollover amount for category: {sCategory} for 'Roll over at the end of each month' in Annual View is updated as expected: {sCurrentMonthRolloverAmount} for future year: {sFutureYear}.")
									[+] else
										[ ] ReportStatus("Verfiy that rollover amount has been updated on Annual View for future year: {sFutureYear}." ,FAIL, "The rollover amount for category: {sCategory} for 'Roll over at the end of each month' in Annual View didn't update as expected: {sCurrentMonthRolloverAmount} for future year: {sFutureYear}.")
									[ ] 
									[ ] 
									[ ] 
									[ ] ////Apply 'Undo all rollover edits for year 2014 (set to default)' option on Annual View
									[ ] SelectDeselectRollOverOptions (sCategory, sUndoAllRolloverEdits,FALSE)
									[ ] MDIClient.Budget.AnnualViewTypeComboBox.Select("Balance only")
									[ ] sleep(2)
									[ ] 
									[ ] ////Verify applying 'Undo all rollover edits for year 2014 (set to default)' resets the rollover value to original values on Annual View
									[+] for (iCount=1 ; iCount<=iListCount;++iCount)
										[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
										[ ] 
										[ ] bMatch = MatchStr("*{iFutureCatTotalRolloverAmount}*", StrTran(sActual,",",""))
										[+] if (bMatch)
											[ ] break
									[+] if(bMatch)
										[ ] ReportStatus("Verify applying 'Undo all rollover edits for year {sFutureYear} (set to default)' resets the rollover value to original values on Annual View for future year: {sFutureYear}." ,PASS, "The rollover for category: {sCategory} has been reset to original values: {iFutureCatTotalRolloverAmount} on Annual View for future year: {sFutureYear}.")
									[+] else
										[ ] ReportStatus("Verify applying 'Undo all rollover edits for year {sFutureYear} (set to default)' resets the rollover value to original values on Annual View or future year: {sFutureYear}." ,FAIL, "The rollover for category: {sCategory} couldn't be reset to original values: {iFutureCatTotalRolloverAmount} on Annual View for future year: {sFutureYear}.")
									[ ] 
									[ ] 
								[+] else
									[ ] ReportStatus("Verify Rollover reset amount textfield enabled after clicking on Edit button." , FAIL , "Rollover reset amount textfield didn't get enable after clicking on Edit button.")
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Rollover reset dialog appeared." , FAIL , "Rollover reset dialog didn't appear.")
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify the Budget can be extended to next year." , FAIL, "Dialog:{sActual} didn't appear.")
						[ ] 
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify that User is able to add average budget for category: {sCategory} with amount: {iBudgetAmount}."  , FAIL,"Average budget for category: {sCategory} with amount: {iBudgetAmount} couldn't be added for 12 months on Graph View.")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify budget gets added.", FAIL, "Budget: {sBudgetName} couldn't be added.")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify budget gets deleted.", FAIL, "Budget: {sBudgetName} couldn't be deleted.")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
	[ ] 
[ ] 
[+] //##########Test 110A: Verify the functionality of canceling rollover reset from either the graph or Annual view for Past Year #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test110B_VerifyTheCancellingRolloverResetForPastYearFromAnnualView
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify the functionality of canceling rollover reset from either the graph or Annual view for Past Year
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If  functionality of canceling rollover reset from either the graph or Annual view for Past Year is correct
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  Aug 7 2014
	[ ] // ********************************************************
[ ] 
[+] testcase Test110B_VerifyTheCancellingRolloverResetForPastYearFromAnnualView() appstate none
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] LIST OF STRING lsExpectedTxnRollOverAmount 
		[ ] STRING  sCurrentMonthRolloverAmount,sPastYear 
		[ ] INTEGER  iPastMonths ,iPastYearRollOverAmount ,iPastYearTxnAmount ,iRolloverEditAmount ,iPastMonthAmount
		[ ] iRolloverEditAmount=300
		[ ] sBudgetName = "BudgetTest"
		[ ] bMatch=FALSE
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] iBudgetAmount=50
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] lsCategoryList=lsExcelData[1]
		[ ] //delete category type 
		[ ] ListDelete(lsCategoryList ,1)
		[ ] //delete parent category 
		[ ] ListDelete(lsCategoryList ,1)
		[ ] 
		[ ] sCategory=lsCategoryList[1]
		[ ] // Fetch 1st row from sRegTransactionSheet the given sheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sRegTransactionSheet)
		[ ] lsTransaction=lsExcelData[1]
		[ ] iTxnAmount=VAL(lsTransaction[3])
		[ ] 
		[ ] 
		[ ] //Remove null from category list
		[+] for( iCounter=1; iCounter <=ListCount (lsCategoryList) ; iCounter++)
			[+] if (lsCategoryList[iCounter]==NULL)
				[ ] ListDelete (lsCategoryList ,iCounter)
				[ ] iCounter--
				[ ] 
		[ ] 
		[ ] 
		[ ] sCurrentYear = FormatDateTime(GetDateTime(), "yyyy") //Get current month as January 2014
		[ ] sCurrentMonth=FormatDateTime(GetDateTime(), "m") //Get current month as January 2014
		[ ] iCurrentMonth = VAL(sCurrentMonth)
		[ ] iRollOverMonthCount=4
		[ ] 
		[ ] 
		[ ] 
		[ ] //Rollover value calculation
		[+] ///create past year rollover data
			[ ] iTxnMonthCount=4
			[ ] iRollOverWithNoTxnMonthAmount=0
			[ ] iRemainingMonths=12 - iCurrentMonth
			[ ] iRemainingMonthsAmount=iRemainingMonths*iBudgetAmount
			[+] if (iCurrentMonth>4)
				[ ] iRollOverWithNoTxnMonthCount=iCurrentMonth-4
				[ ] iTxnMonthCount=4
			[+] else
				[ ] iTxnMonthCount= iCurrentMonth
				[ ] iRollOverWithNoTxnMonthCount=0
				[ ] 
			[ ] 
			[ ] ///past year rollover amount
			[ ] 
			[ ] iPastMonths =4-iTxnMonthCount
			[+] if (iPastMonths<1)
				[ ] iPastYearRollOverAmount = iBudgetAmount*12
			[+] else
				[ ] iPastYearTxnAmount = iPastMonths*iTxnAmount
				[ ] iPastYearRollOverAmount= (iBudgetAmount*12) - iPastYearTxnAmount
			[ ] 
			[ ] 
			[+] if (iTxnMonthCount>1)
				[ ] 
				[ ] ///Get rollover amounts for months for whom there are no transactions
				[+] if (iRollOverWithNoTxnMonthCount > 0)
					[ ] iExpectedNoTxnRollOverAmount=iBudgetAmount+iPastYearRollOverAmount
					[ ] sExpectedNoTxnRollOverAmount="*{iBudgetAmount+iPastYearRollOverAmount}*"
					[+] for (iCount=2; iCount<=iRollOverWithNoTxnMonthCount; iCount++)
						[ ] sExpectedNoTxnRollOverAmount =sExpectedNoTxnRollOverAmount +"*{iBudgetAmount+iExpectedNoTxnRollOverAmount}*"
						[ ] iExpectedNoTxnRollOverAmount=iBudgetAmount+iExpectedNoTxnRollOverAmount
				[+] else
					[ ] sExpectedNoTxnRollOverAmount=""
					[ ] iExpectedNoTxnRollOverAmount=iPastYearRollOverAmount
				[ ] 
				[ ] ///Get rollover amounts for months for whom there are  transactions
				[ ] iDiffOfBudgetTxnAmount= iBudgetAmount-iTxnAmount
				[ ] 
				[ ] iExpectedTxnRollOverAmount=iExpectedNoTxnRollOverAmount+iDiffOfBudgetTxnAmount
				[ ] sExpectedTxnRollOverAmount="*{str(iExpectedTxnRollOverAmount)}*"
				[+] for (iCount=2; iCount<=iTxnMonthCount; iCount++)
					[ ] 
					[ ] iExpectedTxnRollOverAmount=iExpectedTxnRollOverAmount + iDiffOfBudgetTxnAmount
					[ ] sExpectedTxnRollOverAmount =sExpectedTxnRollOverAmount +"*{iExpectedTxnRollOverAmount}*"
					[ ] 
					[ ] 
					[ ] 
				[ ] 
				[ ] iTotalRolloverAmount=iExpectedTxnRollOverAmount+iRemainingMonthsAmount
			[+] else
				[ ] iExpectedNoTxnRollOverAmount=0
				[ ] iExpectedTxnRollOverAmount=iPastYearRollOverAmount
				[ ] sExpectedNoTxnRollOverAmount="0"
				[ ] sExpectedTxnRollOverAmount="0"
				[ ] iTotalRolloverAmount=11*iBudgetAmount +iPastYearRollOverAmount
		[ ] 
		[ ] 
		[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
		[+] if (iResult==PASS)
			[ ] sleep(2)
			[ ] iResult=DeleteBudget()
			[+] if (iResult==PASS)
				[ ] iResult=AddBudget(sBudgetName)
				[+] if (iResult==PASS)
					[ ] ReportStatus("Verify budget gets added.", PASS, "Budget: {sBudgetName} has been added.")
					[ ] 
					[ ] QuickenWindow.SetActive()
					[ ] 
					[ ] 
					[ ] //// Set Parent rollup on
					[ ] SelectBudgetOptionOnGraphAnnualView(sGraphView,"Rollup")
					[ ] sleep(2)
					[ ] 
					[ ] //set average budget as zero for two other categories to make textclick on the rollover category specific
					[ ] QuickenWindow.SetActive()
					[ ] AddAverageBudget(lsCategoryList[2] ,0)
					[ ] sleep(2)
					[ ] QuickenWindow.SetActive()
					[ ] AddAverageBudget(lsCategoryList[3] ,0)
					[ ] sleep(2)
					[ ] QuickenWindow.SetActive()
					[ ] iResult=AddAverageBudget(sCategory ,iBudgetAmount)
					[+] if (iResult==PASS)
						[ ] QuickenWindow.SetActive()
						[ ] ///Enable Rollover 
						[ ] 
						[ ] SelectDeselectRollOverOptions (sCategory, sSetRollOverBalance,False)
						[ ] 
						[ ] //Verify rollover editing on Annual View
						[ ] 
						[ ] QuickenWindow.SetActive()
						[ ] MDIClient.Budget.BackWardMonthButton.Click()
						[ ] ///Extend budget for next year using second option
						[+] if (DlgAddABudgetForNextOrPreviousYear.Exists(5))
							[ ] DlgAddABudgetForNextOrPreviousYear.SetActive()
							[ ] DlgAddABudgetForNextOrPreviousYear.RadioListCopyThisYearsCategoriesAndActualsAsBudget.Select(1)
							[ ] DlgAddABudgetForNextOrPreviousYear.OKButton.Click()
							[ ] WaitForState(DlgAddABudgetForNextOrPreviousYear , FALSE, 5)
							[ ] 
							[ ] sPastYear =MDIClient.Budget.CurrentMonthStaticText.GetText()
							[ ] 
							[ ] QuickenWindow.SetActive()
							[ ] sleep(1)
							[ ] MDIClient.Budget.AnnualViewTypeComboBox.Select("Balance only")
							[ ] sleep(2)
							[ ] QuickenWindow.SetActive()
							[ ] ////Open Rollover reset popup
							[ ] MDIClient.Budget.ListBox.TextClick(sCategory)
							[ ] sleep(5)
							[ ] MDIClient.Budget.ListBox.TextClick(Str(iPastYearRollOverAmount) ,5)
							[ ] 
							[+] if (RolloverCalloutPopup.Exists(5))
								[ ] ReportStatus("Verify Rollover reset dialog appeared." , PASS , "Rollover reset dialog appeared.")
								[ ] 
								[ ] //click on the edit button
								[ ] RolloverCalloutPopup.EditResetButton.Click()
								[+] if (RolloverCalloutPopup.RolloverAmountTextField.Exists(5))
									[ ] RolloverCalloutPopup.RolloverAmountTextField.SetText(Str(iRolloverEditAmount))
									[ ] RolloverCalloutPopup.SaveButton.Click()
									[ ] WaitForState(RolloverCalloutPopup , False, 2)
									[ ] 
									[ ] //Calculate the updated rollover
									[ ] iPastMonthAmount=0
									[+] if (iPastMonths>1)
										[ ] iPastMonthAmount=iTxnAmount
									[ ] sCurrentMonthRolloverAmount=NULL
									[ ] sCurrentMonthRolloverAmount=STR((iRolloverEditAmount+iBudgetAmount) - iPastMonthAmount) 
									[ ] 
									[ ] QuickenWindow.SetActive()
									[ ] //Verfiy that rollover amount has been updated on graph view
									[ ] sHandle= Str(MDIClient.Budget.ListBox.GetHandle())
									[ ] iListCount= MDIClient.Budget.ListBox.GetItemCount() +1
									[ ] 
									[+] for (iCount=1 ; iCount<=iListCount;++iCount)
										[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
										[ ] 
										[ ] bMatch = MatchStr("*{sCurrentMonthRolloverAmount}*", StrTran(sActual,",",""))
										[+] if (bMatch)
											[ ] break
									[+] if(bMatch)
										[ ] ReportStatus("Verfiy that rollover amount has been updated on Annual View when rollover is enabled for past year: {sPastYear}." ,PASS, "The rollover amount for category: {sCategory} for 'Roll over at the end of each month' in Annual View is updated as expected: {sCurrentMonthRolloverAmount} when rollover is enabled for past year: {sPastYear}.")
									[+] else
										[ ] ReportStatus("Verfiy that rollover amount has been updated on Annual View when rollover is enabled for past year: {sPastYear}." ,FAIL, "The rollover amount for category: {sCategory} for 'Roll over at the end of each month' in Annual View didn't update as expected: {sCurrentMonthRolloverAmount} when rollover is enabled for past year: {sPastYear}.")
									[ ] 
									[ ] 
									[ ] 
									[ ] ////Apply 'Undo all rollover edits for year 2014 (set to default)' option on Annual View
									[ ] SelectDeselectRollOverOptions (sCategory, sUndoAllRolloverEdits,FALSE)
									[ ] MDIClient.Budget.AnnualViewTypeComboBox.Select("Balance only")
									[ ] sleep(2)
									[ ] 
									[ ] ////Verify applying 'Undo all rollover edits for year 2014 (set to default)' resets the rollover value to original values on Annual View
									[+] for (iCount=1 ; iCount<=iListCount;++iCount)
										[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
										[ ] 
										[ ] bMatch = MatchStr("*{iPastYearRollOverAmount}*", StrTran(sActual,",",""))
										[+] if (bMatch)
											[ ] break
									[+] if(bMatch)
										[ ] ReportStatus("Verify applying 'Undo all rollover edits for year {sPastYear} (set to default)' resets the rollover value to original values on Annual View for past year: {sPastYear}." ,PASS, "The rollover for category: {sCategory} has been reset to original values: {iPastYearRollOverAmount} on Annual View for past year: {sPastYear}.")
									[+] else
										[ ] ReportStatus("Verify applying 'Undo all rollover edits for year {sPastYear} (set to default)' resets the rollover value to original values on Annual View or past year: {sPastYear}." ,FAIL, "The rollover for category: {sCategory} couldn't be reset to original values: {iPastYearRollOverAmount} on Annual View for past year: {sPastYear}.")
									[ ] 
									[ ] 
								[+] else
									[ ] ReportStatus("Verify Rollover reset amount textfield enabled after clicking on Edit button." , FAIL , "Rollover reset amount textfield didn't get enable after clicking on Edit button.")
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Rollover reset dialog appeared." , FAIL , "Rollover reset dialog didn't appear.")
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify the Budget can be extended to next year." , FAIL, "Dialog:{sActual} didn't appear.")
						[ ] 
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify that User is able to add average budget for category: {sCategory} with amount: {iBudgetAmount}."  , FAIL,"Average budget for category: {sCategory} with amount: {iBudgetAmount} couldn't be added for 12 months on Graph View.")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify budget gets added.", FAIL, "Budget: {sBudgetName} couldn't be added.")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify budget gets deleted.", FAIL, "Budget: {sBudgetName} couldn't be deleted.")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
	[ ] 
[ ] 
[+] //##########Test 127: Verify that in Budget annual view 'budget only' view is displayed and All the months from Jan to Dec are displayed without the horizontal scroll. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test127_VerifyThatAllTheMonthsAreDisplayedOnBudgetOnlyViewWithoutHorizontalScroll
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that in Budget annual view 'budget only' view is displayed and All the months from Jan to Dec are displayed without the horizontal scroll
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Budget annual view 'budget only' view is displayed and All the months from Jan to Dec are displayed without the horizontal scroll
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  Aug 11 2014
	[ ] // ********************************************************
[ ] 
[+] testcase Test127_VerifyThatAllTheMonthsAreDisplayedOnBudgetOnlyViewWithoutHorizontalScroll() appstate none
	[ ] 
	[+] //--------------Variable Declaration------------
		[ ] STRING sMonth
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
		[+] if (iResult==PASS)
			[ ] //select graph view
			[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sAnnualView)
			[ ] sleep(10)
			[ ] MDIClient.Budget.AnnualViewTypeComboBox.Select("Budget only")
			[ ] sleep(2)
			[ ] 
			[+] if (!MDIClient.Budget.HScrollBar.Exists(2))
				[ ] ReportStatus("Verfiy that horizontal scroll bar is not present on 'Annual View > Budget only'." , PASS , "Horizontal scroll bar is not present on 'Annual View > Budget only'.")
				[ ] 
				[ ] //Verfiy that all months are present on 'Budget only' view without horizontal scroll bar
				[+] for each sMonth in lsListOfMonths
					[+] do 
						[ ] MDIClient.Budget.ListViewer.TextClick(Left(sMonth ,3))
						[ ] QuickenWindow.TypeKeys(KEY_ESC)
						[ ] ReportStatus("Verfiy that all months are present on 'Annual View > Budget only' view without horizontal scroll bar." , PASS , "Month: {sMonth} is present on 'Annual View > Budget only' view without horizontal scroll bar.")
					[+] except
						[ ] ReportStatus("Verfiy that all months are present on 'Annual View > Budget only' view without horizontal scroll bar." , FAIL , "Month: {sMonth} is NOT present on 'Annual View > Budget only' view without horizontal scroll bar.")
				[ ] 
			[+] else
				[ ] ReportStatus("Verfiy that horizontal scroll bar is not present on 'Annual View > Budget only'." , FAIL , "Horizontal scroll bar is present on 'Annual View > Budget only'.")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
	[ ] 
[ ] 
[ ] 
[+] //##########Test 130: Verify the presence of an Icon on Budget Annual View for history pop-up for the selected category. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test130_VerifyThePressenceOfTransactionPopupIconAlogWithCategoryOnAnnualView
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify the presence of an Icon on Budget Annual View for history pop-up for the selected category
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If an Icon on Budget Annual View for history pop-up for the selected category is present
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  Aug 11 2014
	[ ] // ********************************************************
[ ] 
[+] testcase Test130_VerifyThePressenceOfTransactionPopupIconAlogWithCategoryOnAnnualView() appstate none
	[ ] 
	[+] //--------------Variable Declaration------------
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] lsCategoryList=lsExcelData[1]
		[ ] //delete category type 
		[ ] ListDelete(lsCategoryList ,1)
		[ ] //delete parent category 
		[ ] ListDelete(lsCategoryList ,1)
		[ ] 
		[ ] sCategory=lsCategoryList[1]
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
		[+] if (iResult==PASS)
			[ ] //select graph view
			[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sAnnualView)
			[ ] sleep(10)
			[ ] MDIClient.Budget.AnnualViewTypeComboBox.Select("Budget only")
			[ ] sleep(2)
			[ ] 
			[ ] MDIClient.Budget.ListBox.TextClick(sCategory)
			[ ] MDIClient.Budget.ListBox.Amount.Click()
			[ ] pPoint=Cursor.GetPosition()
			[ ] QuickenWindow.Click(1, pPoint.x-85 ,pPoint.y+5)
			[+] if (CalloutPopup.GraphControl.Exists(5))
				[ ] ReportStatus("Verify the presence of an Icon on Budget Annual View for history pop-up for the selected category.", PASS , "Transaction popup appeared.")
				[+] if (CalloutPopup.GraphControl.Exists(5))
					[ ] ReportStatus("Verify that history tab is displayed by default on transaction popup." , PASS , " History tab is displayed by default on transaction popup.")
				[+] else
					[ ] ReportStatus("Verify that history tab is displayed by default on transaction popup." , FAIL , " History tab didn't display by default on transaction popup.")
				[ ] 
				[ ] CalloutPopup.Close.Click()
				[ ] WaitForState(CalloutPopup , False ,2)
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify the presence of an Icon on Budget Annual View for history pop-up for the selected category.", FAIL , "Transaction popup didn't appear.")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
	[ ] 
[ ] 
[ ] 
[ ] 
[+] //##########Test 137: Verify the presence of the options "Ignore Savings to Savings Account transfer" & "Ignore Savings to Savings Goal transfer" in Budget Action menu. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test137_VerifyTheIgnoreSavingsToSavingsAccountTransferAndIgnoreSavingsToSavingsGoalTransferOptions
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify the presence of the options "Ignore Savings to Savings Account transfer" & "Ignore Savings to Savings Goal transfer" in Budget Action menu
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If  options "Ignore Savings to Savings Account transfer" & "Ignore Savings to Savings Goal transfer" are present in Budget Action > Preferences 
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  July 31 2014
	[ ] // ********************************************************
[ ] 
[+] testcase Test137_VerifyTheIgnoreSavingsToSavingsAccountTransferAndIgnoreSavingsToSavingsGoalTransferOptions() appstate none
	[ ] 
	[+] //--------------Variable Declaration------------
		[ ] 
		[ ] STRING sActualYear , sRemainingMonthsAmountPattern ,sLeftOver
		[ ] BOOLEAN bMatch=FALSE
		[ ] iBudgetAmount=50
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] lsCategoryList=lsExcelData[1]
		[ ] sCategory=lsCategoryList[3]
		[ ] // Fetch 1st row from sRegTransactionSheet the given sheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sRegTransactionSheet)
		[ ] lsTransaction=lsExcelData[1]
		[ ] iTxnAmount=VAL(lsTransaction[3])
		[ ] 
		[ ] sCurrentMonth=FormatDateTime(GetDateTime(), "m") //Get current month as January 2014
		[ ] iCurrentMonth = VAL(sCurrentMonth)
		[ ] sCurrentYear=FormatDateTime(GetDateTime(),"yyyy")
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
		[+] if (iResult==PASS)
			[ ] //select graph view
			[ ] MDIClient.Budget.BudgetViewTypeComboBox.Select(sGraphView)
			[ ] //Verfiy Budget Prefernces option on Graph View
			[ ] sleep(4)
			[ ] QuickenWindow.SetActive()
			[ ] MDIClient.Budget.BudgetActions.Click()
			[ ] sleep(1)
			[ ] MDIClient.Budget.BudgetActions.TypeKeys(replicate(KEY_DN,8))  
			[ ] sleep(1)
			[ ] MDIClient.Budget.BudgetActions.TypeKeys(KEY_ENTER)
			[+] if (DlgBudgetPreferences.Exists(5))
				[ ] ReportStatus("Verify that Budget Prefernces option is present in Budget Actions Drop Down on Graph View.", PASS , "Budget Prefernces option is present in Budget Actions Drop Down on Graph View.") 
				[ ] DlgBudgetPreferences.SetActive()
				[ ] 
				[ ] //Verfy 'Don't include Savings Account to Savings Account transfer' option
				[+] if (DlgBudgetPreferences.FirstCheckBox.Exists())
					[ ] ReportStatus("Verfy 'Don't include Savings Account to Savings Account transfer' option on Budget Preferences dialog." ,PASS ," 'Don't include Savings Account to Savings Account transfer' option is available on Budget Preferences dialog.")
				[+] else
					[ ] ReportStatus("Verfy 'Don't include Savings Account to Savings Account transfer' option on Budget Preferences dialog." ,FAIL ," 'Don't include Savings Account to Savings Account transfer' option is NOT available on Budget Preferences dialog.")
				[ ] 
				[ ] //Verfy 'Don't include Savings Account to Savings Goal transfer' option
				[+] if (DlgBudgetPreferences.SecondCheckBox.Exists())
					[ ] ReportStatus("Verfy 'Don't include Savings Account to Savings Goal transfer' option on Budget Preferences dialog." ,PASS ,"'Don't include Savings Account to Savings Goal transfer' option is available on Budget Preferences dialog.")
				[+] else
					[ ] ReportStatus("Verfy 'Don't include Savings Account to Savings Goal transfer' option on Budget Preferences dialog." ,FAIL ,"'Don't include Savings Account to Savings Goal transfer' option is NOT available on Budget Preferences dialog.")
				[ ] //The transfers which are ignored will not be included in your budget.
				[+] if (DlgBudgetPreferences.TransferswhichareignoredwillText.Exists() && DlgBudgetPreferences.TransferswhichareignoredwillText.Exists())
					[ ] ReportStatus("Verfy 'The transfers which are ignored will not be included in your budget text on Budget Preferences dialog." ,PASS ,"The transfers which are ignored will not be included in your budget' text is available on Budget Preferences dialog.")
				[+] else
					[ ] ReportStatus("Verfy 'The transfers which are ignored will not be included in your budget text on Budget Preferences dialog." ,FAIL ,"The transfers which are ignored will not be included in your budget' text is NOT available on Budget Preferences dialog.")
				[ ] 
				[ ] //These preferences apply to all budgets.
				[+] if (DlgBudgetPreferences.ThesePreferencesApplyToAllBudgetsText.Exists())
					[ ] ReportStatus("Verfy 'These preferences apply to all budgets.' text on Budget Preferences dialog." ,PASS ,"These preferences apply to all budgets.' text is available on Budget Preferences dialog.")
				[+] else
					[ ] ReportStatus("Verfy 'These preferences apply to all budgets.' text on Budget Preferences dialog." ,FAIL ,"These preferences apply to all budgets.' text is NOT available on Budget Preferences dialog.")
				[ ] 
				[ ] 
				[ ] //Verfiy the Help button.
				[+] if (DlgBudgetPreferences.HelpButton.Exists())
					[ ] ReportStatus("Verfy 'Help' button exists on Budget Preferences dialog." ,PASS ,"'Help' button exists on Budget Preferences dialog.")
				[+] else
					[ ] ReportStatus("Verfy 'Help' button exists on Budget Preferences dialog." ,FAIL ,"'Help' button is missing on Budget Preferences dialog.")
				[ ] 
				[ ] //Verfiy the OK button.
				[+] if (DlgBudgetPreferences.OKButton.Exists())
					[ ] ReportStatus("Verfy 'OK' button exists on Budget Preferences dialog." ,PASS ,"'OK' button exists on Budget Preferences dialog.")
				[+] else
					[ ] ReportStatus("Verfy 'OK' button exists on Budget Preferences dialog." ,FAIL ,"'OK' button is missing on Budget Preferences dialog.")
				[ ] //Verfiy the Cancel button.
				[+] if (DlgBudgetPreferences.CancelButton.Exists())
					[ ] ReportStatus("Verfy 'Cancel' button exists on Budget Preferences dialog." ,PASS ,"'Cancel' button exists on Budget Preferences dialog.")
				[+] else
					[ ] ReportStatus("Verfy 'Cancel' button exists on Budget Preferences dialog." ,FAIL ,"'Cancel' button is missing on Budget Preferences dialog.")
				[ ] 
				[ ] DlgBudgetPreferences.CancelButton.Click()
				[ ] WaitForState(QuickenWindow,TRUE,2)
			[+] else
				[ ] ReportStatus("Verify that Budget Prefernces option is present in Budget Actions Drop Down on Graph View.", FAIL , "Budget Prefernces option is not present in Budget Actions Drop Down on Graph View.") 
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
	[ ] 
[ ] 
[ ] 
[ ] 
[ ] 
[ ] 
[ ] 
[ ] 
[ ] //This testcase needs to be placed last due to new data file creation
[+] //##########Test 63: Verify budget amount for the category when automatic budget created and re-adding the category to budget. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test63_VerifyAutomaticBudgetCreationAndReaddingACategoryToBudget
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify budget amount for the category when automatic budget created and re-adding the category to budget
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If budget amount for the category when automatic budget created  is correct and re-adding the category to budget
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  July 11 2014
		[ ] //
	[ ] // ********************************************************
[ ] 
[+] testcase Test63_VerifyAutomaticBudgetCreationAndReaddingACategoryToBudget() appstate none
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] sBudgetName = "BudgetTest"
		[ ] bMatch=FALSE
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] sAccountName=lsAddAccount[2]
		[ ] iBudgetAmount=50
		[ ] // Fetch 1st row from sRegTransactionSheet the given sheet
		[ ] lsTxnExcelData=NULL
		[ ] lsTxnExcelData=ReadExcelTable(sBudgetExcelsheet, sRegTransactionSheet)
		[ ] ///Spending for firs
		[ ] lsTransaction=lsExcelData[1]
		[ ] iTxnAmount=VAL(lsTransaction[3])
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sBudgetExcelsheet, sCategoriesWorksheet)
		[ ] iBudgetAmount=0
		[ ] ///Remove category type and parent category from the list
		[ ] lsCategoryList = lsExcelData[1]
		[ ] sCategoryType =lsCategoryList[1]
		[ ] ListDelete (lsCategoryList ,1)
		[ ] ListDelete (lsCategoryList ,1)
		[ ] //Remove NULL from category list
		[ ] 
		[+] for( iCounter=1; iCounter <=ListCount (lsCategoryList) ; iCounter++)
			[+] if (lsCategoryList[iCounter]==NULL)
				[ ] ListDelete (lsCategoryList ,iCounter)
				[ ] iCounter--
				[ ] 
		[ ] iListCount=ListCount (lsCategoryList)
		[ ] ///Get the first sub-category
		[ ] sCategory=trim(lsCategoryList[1])
		[ ] 
		[ ] 
	[ ] iResult=DataFileCreate(sBudgetFileName)
	[+] if (iResult==PASS)
		[+] if(QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
			[ ] iResult = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4])
			[ ] // Verify checking Account is created
			[+] if (iResult==PASS)
				[ ] ReportStatus("{lsAddAccount[1]} Account", PASS, "{lsAddAccount[1]} Account -  {lsAddAccount[2]}  is created successfully")
				[ ] iResult= SelectAccountFromAccountBar(sAccountName, ACCOUNT_BANKING)
				[+] if (iResult==PASS)
					[+] for (iCounter=1 ; iCounter<=3; iCounter++)
						[ ] lsTransaction=lsTxnExcelData[iCounter]
						[+] if(lsTransaction[1]==NULL)
							[ ] break
						[ ] ///Calculate total spending
						[ ] iTxnAmount=VAL(lsTransaction[3]) +(iCounter*2)
						[ ] // iTotalSpending =iTxnAmount*4+iTotalSpending
						[ ] 
						[+] if (iCounter>0)
							[+] for (iCount=3 ; iCount>=0; iCount--)
								[ ] QuickenWindow.SetActive()
								[ ] sDate=GetPreviousMonth(iCount)
								[ ] AddCheckingTransaction(lsTransaction[1],lsTransaction[2],lsTransaction[3],sDate,lsTransaction[5],lsTransaction[6],lsTransaction[7],lsTransaction[8])
								[ ] 
					[ ] 
					[ ] iResult=NavigateQuickenTab(sTAB_PLANNING , sTAB_BUDGET)
					[+] if (iResult==PASS)
						[ ] sleep(2)
						[ ] iResult=DeleteBudget()
						[+] if (iResult==PASS)
							[ ] iResult=AddBudget(sBudgetName)
							[+] if (iResult==PASS)
								[ ] ReportStatus("Verify budget gets added.", PASS, "Budget: {sBudgetName} has been added.")
								[ ] 
								[ ] QuickenWindow.SetActive()
								[ ] 
								[ ] 
								[ ] //// Set Parent rollup on
								[ ] SelectBudgetOptionOnGraphAnnualView(sGraphView,"Rollup")
								[ ] sleep(2)
								[ ] 
								[ ] 
								[ ] QuickenWindow.SetActive()
								[+] for (iCounter=1 ;  iCounter<= 3; iCounter++)
									[ ] lsTransaction=lsTxnExcelData[iCounter]
									[+] if(lsTransaction[1]==NULL)
										[ ] break
									[ ] 
									[ ] sCategory=lsTransaction[8]
									[ ] iTxnAmount=VAL(lsTransaction[3])
									[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify budget gets added.", FAIL, "Budget: {sBudgetName} couldn't be added.")
							[ ] 
						[+] else
							[ ] ReportStatus("Verify budget gets deleted.", FAIL, "Budget: {sBudgetName} couldn't be deleted.")
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Quicken navigated to Budget. ", FAIL , "Quicken didn't navigate to Budget.") 
				[+] else
					[ ] ReportStatus("Verfiy account: {sAccountName} selected." , FAIL ,"Account: {sAccountName} coulkdn't be selected.")
				[ ] 
			[+] else
				[ ] ReportStatus("{lsAddAccount[1]} Account", FAIL, "{lsAddAccount[1]} Account -  {lsAddAccount[2]}  is not created")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken exists. ", FAIL , "Quicken does not exist.") 
	[+] else
		[ ] ReportStatus("Create Data File",FAIL,"Data File: {sBudgetFileName} couldn't be created.")
	[ ] 
	[ ] 
[ ] 
[ ] 
[ ] 
[ ] 
