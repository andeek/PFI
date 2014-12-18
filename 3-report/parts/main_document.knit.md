---
title: "PFI - Thompson Report"
author: "Maggie Johnson, Andee Kaplan, Colin Lewis-Beck, Michael Price, and Pete Walsh"
date: "11/24/2014"
output:
  pdf_document:
    includes:
      in_header: extra/preamble.tex
    number_sections: yes
bibliography: extra/refs.bib
---







# Data

The data comes to us following a 2009 report by Practical Farmers of Iowa (PFI) on agriculture alternatives by Dick Thompson. His report is available on the [PFI website](http://practicalfarmers.org/wp-content/uploads/2014/01/Ch7_Economics.pdf). The Thompson dataset was collected from 1988 to 2012 and contains Thompson's farming practices and results as well as his neighbor's farming practices and the Boone county average yield and expenses for the corresponding practices.

The dataset was organized as an Excel spreadsheet with each year of data being contained in its own sheet. Within each year the data had each row as an expense/revenue/unit price/derived quantity, as well as totals and averages. Each column corresponded to a field in either Thompson's or his neighbor's farm. We have transformed this complicated structure into a single `csv` with a row corresponding to each year/field/item granularity. The columns include the year, field, farmer, crop, item, item type, and value of the item. The item type was created by us, to better understand the relationship of the items. Additionally, any averages and totals have been removed to avoid confusion. This puts the data in more of a `tidy' form, as described in [@wickham2014tidy].

In addition to reformatting the dataset, we have created a data dictionary that defines and categorizes each data item in the spreadsheet. This dictionary is printed in full in table \ref{tab:data_dictionary}.

\begin{table}[ht]
\centering
\begin{tabular}{lllp{.3\textwidth}}
  \hline
qColumn & Var\_Name & Var\_Type & Desc \\ 
  \hline
Crop & Crop & Crop & Crop identifier. Options include corn, soy bean, oats/legume, and hay. \\ 
  Apply NH4 & Apply\_NH4 & Expense & Expense of applying NH4. \\ 
  Bale Hay & Bale\_Hay & Expense & Cost of baling hay. \\ 
  Chop Stks.C.c. & Chop\_StksCc & Expense &  \\ 
  Corn RSL & Corn\_RSL & Expense &  \\ 
  Cover Crop & Cover\_Crop & Expense & Cost of applying cover crop. \\ 
  Crop Ins. & Crop\_Ins & Expense & Cost of purchasing crop insurance. \\ 
  Cultivation & Cultivation & Expense & Expense of cultivating a field. \\ 
  Drying Cost & Drying\_Cost & Expense & Cost of drying corn. \\ 
  Fall Tillage & Fall\_Tillage & Expense & Cost of applying fall tillage. \\ 
  Grain Handling & Grain\_Handling & Expense & Grain handling fee. \\ 
  Grain Harvest & Grain\_Harvest & Expense & Cost of harvesting grain. \\ 
  Hedge/P.L. & Hedge\_per\_PL & Expense & Hedge or priced later. \\ 
  Herbicides & Herbicides & Expense & Herbicide costs. \\ 
  Interest & Interest & Expense &  \\ 
  Land Change & Land\_Change & Expense &  \\ 
  Maunure Charge & Maunure\_Charge & Expense & Cost of applying manure to fields. \\ 
  Misc. Expense Per Acre & Misc\_Expense\_Per\_Acre & Expense & Miscellaneous expenses per acre. \\ 
  Mov \& Stor bales & Mov\_and\_Stor\_bales & Expense & Cost of moving and storing hay bales. \\ 
  Mow/Windrow & Mow\_per\_Windrow & Expense & Cost of mowing/windrowing. \\ 
  Planting & Planting & Expense & Cost of planting fields. \\ 
  Purch. Pert. & Purch\_Pert & Expense &  \\ 
  Rake & Rake & Expense & Cost of raking (hay or oats). \\ 
  Rotary Hoe & Rotary\_Hoe & Expense & Cost of using rotary hoe. \\ 
  Seed & Seed & Expense & Seed costs. \\ 
  Shell/Grind & Shell\_per\_Grind & Expense &  \\ 
  Spray/Walk & Spray\_per\_Walk & Expense &  \\ 
  Spring Tillage & Spring\_Tillage & Expense & Cost of applying spring tillage. \\ 
  Stack Residues & Stack\_Residues & Expense & Cost of stacking crop residues. \\ 
  Storage & Storage & Expense & Cost of storing harvest. \\ 
  Straw Costs & Straw\_Costs & Expense & Cost of straw. \\ 
  Stubble Costs & Stubble\_Costs & Expense & Cost of stubble. \\ 
  Windrow Oats & Windrow\_Oats & Expense & Cost of windrowing oats. \\ 
  Crop Income & Crop\_Income & Revenue & Revenue from crops. \\ 
  Pasture/Stubble & Pasture\_per\_Stubble & Revenue & Revenue from pasture/stubble \\ 
  Price, Bu./\# & Price\_Bu\_per\_pound & Unit Price & Price per bushel or pound of individual crops. \\ 
  Residue Income & Residue\_Income & Revenue & Revenue from selling crop residue. \\ 
  Straw Income & Straw\_Income & Revenue & Revenue from selling straw. \\ 
  Yield Per Acre. Bu./\# & Yield\_Per\_Acre\_Bu\_per\_pound & Unit Quantity & Crop yields per Acre in bushels or pounds. \\ 
  Cost/bu. Or pound & Cost\_per\_bu\_Or\_pound & Derived & Total expenses divided by yield (Cost per bushel or pound). \\ 
  Labor Return & Labor\_Return & Derived & Wages farmer paid himself. \\ 
  Labor\&M.R. \$/A & LaborandMR\_dollar\_per\_A & Derived & Net income excluding the cost of labor and management. \\ 
   \hline
\end{tabular}
\caption{Data dictionary created by the StatCom team to categarize the Thompson dataset.} 
\label{tab:data_dictionary}
\end{table}


# Expenses
#```{r intro, child='parts/expenses.Rmd', eval=TRUE}
#```

# Yield






