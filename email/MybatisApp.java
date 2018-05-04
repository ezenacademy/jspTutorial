package mybatis.util;

import java.io.IOException;
import java.io.Reader;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class MybatisApp {
	private static SqlSessionFactory factory;
	static {
		String resource = "MybatisConfig.xml";
		Reader reader = null;
		try {
			reader = Resources.getResourceAsReader(resource);
			factory = new SqlSessionFactoryBuilder().build(reader);
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try { reader.close(); } catch (IOException e) { ; }
		}
	}
	public static SqlSessionFactory getSessionFactory() {
		return factory;
	}
}
