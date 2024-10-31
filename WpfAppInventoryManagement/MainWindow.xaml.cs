using System;
using System.Data;
using System.Windows;

namespace WpfAppInventoryManagement
{
    public partial class MainWindow : Window
    {
        private readonly DatabaseHelper dbHelper;

        public MainWindow()
        {
            InitializeComponent();
            dbHelper = new DatabaseHelper();
            LoadData();
        }

        private void LoadData()
        {
            LoadProducts();
            LoadCategories();
            LoadTransactionProducts();
        }

        private void LoadProducts()
        {
            ProductsDataGrid.ItemsSource = dbHelper.GetProducts().DefaultView;
        }

        private void LoadCategories()
        {
            var categories = dbHelper.GetCategories();
            CategoryComboBox.ItemsSource = categories.DefaultView;
            CategoryComboBox.DisplayMemberPath = "CategoryName";
            CategoryComboBox.SelectedValuePath = "CategoryID";
        }

        private void LoadTransactionProducts()
        {
            var products = dbHelper.GetProducts();
            TransactionProductComboBox.ItemsSource = products.DefaultView;
            TransactionProductComboBox.DisplayMemberPath = "Name";
            TransactionProductComboBox.SelectedValuePath = "ProductID";
        }

        private void AddProductButton_Click(object sender, RoutedEventArgs e)
        {
            if (TryGetProductDetails(out string name, out int categoryId, out decimal price, out int stockQuantity))
            {
                dbHelper.AddProduct(name, categoryId, price, stockQuantity);
                LoadData();
            }
        }

        private void UpdateProductButton_Click(object sender, RoutedEventArgs e)
        {
            if (ProductsDataGrid.SelectedItem is DataRowView selectedProduct &&
                TryGetProductDetails(out string name, out int categoryId, out decimal price, out int stockQuantity))
            {
                int productId = (int)selectedProduct["ProductID"];
                dbHelper.UpdateProduct(productId, name, categoryId, price, stockQuantity);
                LoadData();
            }
            else
            {
                MessageBox.Show("Пожалуйста, выберите продукт для обновления и заполните все поля корректно.");
            }
        }

        private void ProductsDataGrid_SelectionChanged(object sender, System.Windows.Controls.SelectionChangedEventArgs e)
        {
            if (ProductsDataGrid.SelectedItem is DataRowView selectedProduct)
            {
                ProductNameTextBox.Text = selectedProduct["Name"].ToString();
                CategoryComboBox.SelectedValue = selectedProduct["CategoryID"];
                PriceTextBox.Text = selectedProduct["Price"].ToString();
                StockQuantityTextBox.Text = selectedProduct["StockQuantity"].ToString();
            }
        }

        private void ExecuteTransactionButton_Click(object sender, RoutedEventArgs e)
        {
            if (TransactionProductComboBox.SelectedValue is int productId &&
                int.TryParse(TransactionQuantityTextBox.Text, out int quantity))
            {
                string transactionType = TransactionTypeComboBox.Text;
                dbHelper.UpdateProductStock(productId, transactionType, quantity);
                LoadData();
            }
            else
            {
                MessageBox.Show("Пожалуйста, выберите продукт и введите корректное количество.");
            }
        }

        private bool TryGetProductDetails(out string name, out int categoryId, out decimal price, out int stockQuantity)
        {
            name = ProductNameTextBox.Text;
            categoryId = (int?)CategoryComboBox.SelectedValue ?? default;
            bool priceValid = decimal.TryParse(PriceTextBox.Text, out price);
            bool stockQuantityValid = int.TryParse(StockQuantityTextBox.Text, out stockQuantity);

            return !string.IsNullOrWhiteSpace(name) &&
                   categoryId != default &&
                   priceValid &&
                   stockQuantityValid;
        }
    }
}
