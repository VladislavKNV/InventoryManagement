   M S B A M L   `   `   `  ����T  PWpfAppInventoryManagement, Version=1.0.0.0, Culture=neutral, PublicKeyToken=nullE'clr-namespace:WpfAppInventoryManagementWpfAppInventoryManagement  5   	   *    $WpfAppInventoryManagement.MainWindow   5   	   W SPresentationCore, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089R NWindowsBase, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     5   	   R NSystem.Xaml, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   9local'clr-namespace:WpfAppInventoryManagement     5   	     � Title$  Inventory Management��5   	   $	��600��6&   $	��800��63    � 	Resources 5	          BooleanToVisibilityConverter��%   &	        �� 5
   
   6'   5      .��5      �  � RowDefinitions 5   
   �� 5      $��* �6   �� 5      $
��Auto �6   �� 5      $
��Auto �6   .+�5   
   &   System.Windows.Controls.DataGrid  -   5        $��ProductsDataGrid��5         AutoGenerateColumns$ False��6+   $��10q�6G      Columns 5      0  *System.Windows.Controls.DataGridTextColumn  5      ,  &System.Windows.Controls.DataGridColumn   Header$ ID��6%      
IsReadOnly$
 True��6O   1  +System.Windows.Controls.DataGridBoundColumn   Binding 61   �� *	ProductID+6O     5      $
 Name��6%    63   �� *Name+  5      $ Category��6%    67   �� *
CategoryID+  5      $ Stock Quantity��6%    6=   �� *StockQuantity+  5      $ Price��6%    64   �� *Price+5      �� 5    
   $��1��6    �� Orientation$ Vertical=�6"   $��10q�69   .+�5!      �� $��Add / Update Product��6   $
��Bold"�64   $��16(�6F   �� 5"      $ 
Horizontal=�6   .+�5#      �� $��5q�6   .+�5$      �� $��Product Name��6    
���   �$��
0, 0, 0, 5q�6G   �� 5%      -   5        $��ProductNameTextBox��5%      $	��200��68   5&      �� 5'      $��5q�6   .+�5(      �� $��Select Category��6    
���   �$��
0, 0, 0, 5q�6J   �� 5)      -   5        $��CategoryComboBox��5)      $	��150��67   5*      �� 5+      $��5q�6   .+�5,      �� $��Price��6    
���   �$��
0, 0, 0, 5q�6@   �� 5-      -   5        $��PriceTextBox��5-      $	��100��62   5.      �� 5/      $��5q�6   .+�50      �� $��Stock Quantity��6    
���   �$��
0, 0, 0, 5q�6I   �� 51      -   5        $��StockQuantityTextBox��51      $	��100��6:   52      53      �� 54      $ 
Horizontal=�6   .+�55      �� -   5        $��AddProductButton��55      $��Add Product��61   $	��100��6G   $��5q�56   8   �� 57      -   5        $��UpdateProductButton��57      $��Update Product��64   $	��100��6M   $��5q�58   ;   59      5:      �� 5=   
   $��2��6   $ Vertical=�6"   $��10q�69   .+�5>      �� $��Manage Transactions��6   $
��Bold"�63   $��16(�6E   �� 5?      $ 
Horizontal=�6   $��5q�62   .+�5@      �� $��5q�6   .+�5A      �� $��Select Product��6    
���   �$��
0, 0, 0, 5q�6I   �� 5B      -   5        $ ��TransactionProductComboBox��5B      $	��150��6A   5C      �� 5D      $��5q�6   .+�5E      �� $��Quantity��6    
���   �$��
0, 0, 0, 5q�6C   �� 5F      -	   5        $ ��TransactionQuantityTextBox��5F      $	��100��6@   5G      �� 5H      $��5q�6   .+�5I      �� $��Transaction Type��6    
���   �$��
0, 0, 0, 5q�6K   �� 5J      -
   5        $��TransactionTypeComboBox��5J      $	��100��6>   .@�5K      �� $��Приход��6'   �� 5L      $��Отгрузка��6'   5M      5N      �� 5O      -   5        $��ExecuteTransactionButton��5O      $��Execute��69   $	��100��6K   $��5q�5P   @   $��42��6K   5Q      5R      5S      5T      