package lzhomework;
import java.awt.EventQueue;
import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;
import java.util.Properties;
import java.util.Vector;

import javax.swing.JFrame;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.JTextArea;
import javax.swing.table.AbstractTableModel;
import javax.swing.table.JTableHeader;
import javax.swing.table.TableColumn;

import java.awt.BorderLayout;
import javax.swing.JButton;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import javax.swing.JLabel;
import javax.swing.JOptionPane;

public class UpdateWindow
{

	private final static String PROP_FILE = "mysql.ini";
	private static String driver;
	private static String url;
	private static String user;
	private static String pass;
	private static Connection conn;
	private static Statement stmt;
	private JScrollPane scrollPane;
	private JTable table;
	private ResultSetTableModel model;
	static
	{
		// 连接数据库
		try
		{
			Properties connProp = new Properties();
			connProp.load(new FileInputStream(PROP_FILE));
			driver = connProp.getProperty("driver");
			url = connProp.getProperty("url");
			user = connProp.getProperty("user");
			pass = connProp.getProperty("pass");
			Class.forName(driver);
			conn = DriverManager.getConnection(url, user, pass);
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
	}
	private JFrame frame;
	private static String primkey;
	private static String Employee;
	private static int i;
	private String sql;
	/**
	 * Launch the application.
	 */
	public static void main(String[] args)
	{
		EventQueue.invokeLater(new Runnable()
		{
			public void run()
			{
				try
				{
					UpdateWindow window = new UpdateWindow(primkey,i);
					window.frame.setVisible(true);
				}
				catch (Exception e)
				{
					e.printStackTrace();
				}
			}
		});
	}

	/**
	 * Create the application.
	 */
	
	
	public UpdateWindow(String s,int t)
	{
		i = t;
		primkey = s;
		initialize(primkey,i);
	}
	public UpdateWindow(String s)
	{
		Employee = s;
		primkey = s;
		initialize(primkey,i);
	}
	public void FitTableColumns(JTable myTable)
	{
		  JTableHeader header = myTable.getTableHeader();
		     int rowCount = myTable.getRowCount();

		     Enumeration columns = myTable.getColumnModel().getColumns();
		     while(columns.hasMoreElements()){
		         TableColumn column = (TableColumn)columns.nextElement();
		         int col = header.getColumnModel().getColumnIndex(column.getIdentifier());
		         int width = (int)myTable.getTableHeader().getDefaultRenderer()
		                 .getTableCellRendererComponent(myTable, column.getIdentifier()
		                         , false, false, -1, col).getPreferredSize().getWidth();
		         for(int row = 0; row<rowCount; row++){
		             int preferedWidth = (int)myTable.getCellRenderer(row, col).getTableCellRendererComponent(myTable,
		               myTable.getValueAt(row, col), false, false, row, col).getPreferredSize().getWidth();
		             width = Math.max(width, preferedWidth);
		         }
		         header.setResizingColumn(column); // 此行很重要
		         column.setWidth(width+myTable.getIntercellSpacing().width);
		     }
	}

	/**
	 * Initialize the contents of the frame.
	 */
	private void initialize(String primkey,int i)
	{
		frame = new JFrame();
		frame.setTitle("\u4FEE\u6539");
		frame.setBounds(100, 100, 896, 300);
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		if (scrollPane != null)
		{
			frame.remove(scrollPane);
		}
		switch (i)
		{
		case 1:
			sql = new String("select * from lzhomework.product_table where 商品编号 = '"+primkey+"'");
			break;
		case 2:
			sql = new String("select * from lzhomework.supplier_table where 供应商编号 = '"+primkey+"'");	
			break;
		}
		
		System.out.println(sql);
		try 
		{
			ResultSet rs = stmt.executeQuery(sql);
			// 使用查询到的ResultSet创建TableModel对象
			model = new ResultSetTableModel(rs);
			// 为TableModel添加监听器，监听用户的修改
			model.addTableModelListener(evt ->
			{
				int row = evt.getFirstRow();
				int column = evt.getColumn();
				JOptionPane.showMessageDialog(frame, "修改成功\n修改的列:" + column + "\n修改的行:" + row + "\n修改后的值:" + model.getValueAt(row, column)+"\n");
			});
			frame.getContentPane().setLayout(null);
			// 使用TableModel创建JTable，并将对应表格添加到窗口中
			table = new JTable(model);
			table.setAutoResizeMode(0);
			FitTableColumns(table);
			scrollPane = new JScrollPane(table);
			scrollPane.setBounds(10, 10, 860, 121);
			frame.getContentPane().add(scrollPane);
			
			
			JButton btnNewButton = new JButton("返回");
			btnNewButton.addActionListener(new ActionListener() {
				public void actionPerformed(ActionEvent e) {
					switch (i)
					{
					case 1:
					{
						Product Product = new Product();
						Product.main(null);
						frame.dispose();
					}
					break;
					case 2:
					{
						Supplier Supplier = new Supplier();
						Supplier.main(null);
						frame.dispose();
					}
					break;
					
					
					}
					
				}
			});
			btnNewButton.setBounds(368, 188, 93, 23);
			frame.getContentPane().add(btnNewButton);
			
			JLabel lblenter = new JLabel("\u6CE8\uFF1A\u4F7F\u7528ENTER\u952E\u786E\u5B9A\u4FEE\u6539");
			lblenter.setBounds(10, 228, 190, 23);
			frame.getContentPane().add(lblenter);
			frame.validate();
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
	}
}
class ResultSetTableModel extends AbstractTableModel // ①
{
	private ResultSet rs;
	private ResultSetMetaData rsmd;

	// 构造器，初始化rs和rsmd两个属性
	public ResultSetTableModel(ResultSet aResultSet)
	{
		rs = aResultSet;
		try
		{
			rsmd = rs.getMetaData();
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
	}

	// 重写getColumnName方法，用于为该TableModel设置列名
	public String getColumnName(int c)
	{
		try
		{
			return rsmd.getColumnName(c + 1);
		}
		catch (SQLException e)
		{
			e.printStackTrace();
			return "";
		}
	}

	// 重写getColumnCount方法，用于设置该TableModel的列数
	public int getColumnCount()
	{
		try
		{
			return rsmd.getColumnCount();
		}
		catch (SQLException e)
		{
			e.printStackTrace();
			return 0;
		}
	}

	// 重写getValueAt方法，用于设置该TableModel指定单元格的值
	public Object getValueAt(int r, int c)
	{
		try
		{
			rs.absolute(r + 1);
			return rs.getObject(c + 1);
		}
		catch (SQLException e)
		{
			e.printStackTrace();
			return null;
		}
	}

	// 重写getColumnCount方法，用于设置该TableModel的行数
	public int getRowCount()
	{
		try
		{
			rs.last();
			return rs.getRow();
		}
		catch (SQLException e)
		{
			e.printStackTrace();
			return 0;
		}
	}

	// 重写isCellEditable返回true，让每个单元格可编辑
	public boolean isCellEditable(int rowIndex, int columnIndex)
	{
		return true;
	}

	// 重写setValueAt()方法，当用户编辑单元格时，将会触发该方法
	public void setValueAt(Object aValue, int row, int column)
	{
		try
		{
			// 结果集定位到对应的行数
			rs.absolute(row + 1);
			// 修改单元格多对应的值
			rs.updateObject(column + 1, aValue);
			// 提交修改
			rs.updateRow();
			// 触发单元格的修改事件
			fireTableCellUpdated(row, column);
		}
		catch (SQLException evt)
		{
			evt.printStackTrace();
		}
	}
}

