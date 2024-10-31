using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace WpfAppInventoryManagement
{
    public class DatabaseHelper
    {
        private readonly string connectionString;

        public DatabaseHelper()
        {
            connectionString = ConfigurationManager.ConnectionStrings["InventoryDb"].ConnectionString;
        }

        private void ExecuteStoredProcedure(string storedProcedure, Action<SqlCommand> parametersAction)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            using (SqlCommand command = new SqlCommand(storedProcedure, connection))
            {
                command.CommandType = CommandType.StoredProcedure;
                parametersAction(command);
                connection.Open();
                command.ExecuteNonQuery();
            }
        }

        private DataTable GetDataTableFromStoredProcedure(string storedProcedure)
        {
            DataTable dataTable = new DataTable();

            using (SqlConnection connection = new SqlConnection(connectionString))
            using (SqlCommand command = new SqlCommand(storedProcedure, connection))
            {
                command.CommandType = CommandType.StoredProcedure;
                connection.Open();

                using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                {
                    adapter.Fill(dataTable);
                }
            }

            return dataTable;
        }

        public void AddProduct(string name, int categoryId, decimal price, int stockQuantity)
        {
            ExecuteStoredProcedure("AddProduct", command =>
            {
                command.Parameters.AddWithValue("@Name", name);
                command.Parameters.AddWithValue("@CategoryID", categoryId);
                command.Parameters.AddWithValue("@Price", price);
                command.Parameters.AddWithValue("@StockQuantity", stockQuantity);
            });
        }

        public DataTable GetProducts()
        {
            return GetDataTableFromStoredProcedure("GetProducts");
        }

        public DataTable GetCategories()
        {
            return GetDataTableFromStoredProcedure("GetCategories");
        }

        public void UpdateProductStock(int productId, string transactionType, int quantity)
        {
            ExecuteStoredProcedure("UpdateProductStock", command =>
            {
                command.Parameters.AddWithValue("@ProductID", productId);
                command.Parameters.AddWithValue("@TransactionType", transactionType);
                command.Parameters.AddWithValue("@Quantity", quantity);
            });
        }

        public void UpdateProduct(int productId, string name, int categoryId, decimal price, int stockQuantity)
        {
            ExecuteStoredProcedure("UpdateProduct", command =>
            {
                command.Parameters.AddWithValue("@ProductID", productId);
                command.Parameters.AddWithValue("@Name", name);
                command.Parameters.AddWithValue("@CategoryID", categoryId);
                command.Parameters.AddWithValue("@Price", price);
                command.Parameters.AddWithValue("@StockQuantity", stockQuantity);
            });
        }
    }
}
