---
title: "Err"
date: 2018-11-20T23:56:55+08:00
draft: false
keywords: []
categories: []
---

```
Error starting ApplicationContext. To display the conditions report re-run your application with 'debug' enabled.
2018-11-20 23:52:15.027 ERROR 11992 --- [           main] o.s.boot.SpringApplication               : Application run failed

org.springframework.beans.factory.UnsatisfiedDependencyException: Error creating bean with name 'defaultCinemaServiceImpl': Unsatisfied dependency expressed through field 'moocCinemaTMapper'; nested exception is org.springframework.beans.factory.UnsatisfiedDependencyException: Error creating bean with name 'moocCinemaTMapper' defined in file [/Users/Mccree/projects/meeting-film/guns-cinema/target/classes/com/stylefeng/guns/rest/common/persistence/dao/MoocCinemaTMapper.class]: Unsatisfied dependency expressed through bean property 'sqlSessionFactory'; nested exception is org.springframework.beans.factory.BeanCreationException: Error creating bean with name 'sqlSessionFactory' defined in class path resource [com/baomidou/mybatisplus/spring/boot/starter/MybatisPlusAutoConfiguration.class]: Bean instantiation via factory method failed; nested exception is org.springframework.beans.BeanInstantiationException: Failed to instantiate [org.apache.ibatis.session.SqlSessionFactory]: Factory method 'sqlSessionFactory' threw exception; nested exception is com.baomidou.mybatisplus.exceptions.MybatisPlusException: Error: GlobalConfigUtils setMetaData Fail !  Cause:java.sql.SQLException: The connection property 'zeroDateTimeBehavior' acceptable values are: 'CONVERT_TO_NULL', 'EXCEPTION' or 'ROUND'. The value 'convertToNull' is not acceptable.
	at org.springframework.beans.factory.annotation.AutowiredAnnotationBeanPostProcessor$AutowiredFieldElement.inject(AutowiredAnnotationBeanPostProcessor.java:587) ~[spring-beans-5.0.5.RELEASE.jar:5.0.5.RELEASE]
	at org.springframework.beans.factory.annotation.InjectionMetadata.inject(InjectionMetadata.java:91) ~[spring-beans-5.0.5.RELEASE.jar:5.0.5.RELEASE]
	at org.springframework.beans.factory.annotation.AutowiredAnnotationBeanPostProcessor.postProcessPropertyValues(AutowiredAnnotationBeanPostProcessor.java:373) ~[spring-beans-5.0.5.RELEASE.jar:5.0.5.RELEASE]
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.populateBean(AbstractAutowireCapableBeanFactory.java:1344) ~[spring-beans-5.0.5.RELEASE.jar:5.0.5.RELEASE]
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.doCreateBean(AbstractAutowireCapableBeanFactory.java:578) ~[spring-beans-5.0.5.RELEASE.jar:5.0.5.RELEASE]
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.createBean(AbstractAutowireCapableBeanFactory.java:501) ~[spring-beans-5.0.5.RELEASE.jar:5.0.5.RELEASE]
	at org.springframework.beans.factory.support.AbstractBeanFactory.lambda$doGetBean$0(AbstractBeanFactory.java:317) ~[spring-beans-5.0.5.RELEASE.jar:5.0.5.RELEASE]
	at org.springframework.beans.factory.support.DefaultSingletonBeanRegistry.getSingleton(DefaultSingletonBeanRegistry.java:228) ~[spring-beans-5.0.5.RELEASE.jar:5.0.5.RELEASE]
	at org.springframework.beans.factory.support.AbstractBeanFactory.doGetBean(AbstractBeanFactory.java:315) ~[spring-beans-5.0.5.RELEASE.jar:5.0.5.RELEASE]
	at org.springframework.beans.factory.support.AbstractBeanFactory.getBean(AbstractBeanFactory.java:199) ~[spring-beans-5.0.5.RELEASE.jar:5.0.5.RELEASE]
	at org.springframework.beans.factory.support.DefaultListableBeanFactory.preInstantiateSingletons(DefaultListableBeanFactory.java:760) ~[spring-beans-5.0.5.RELEASE.jar:5.0.5.RELEASE]
	at org.springframework.context.support.AbstractApplicationContext.finishBeanFactoryInitialization(AbstractApplicationContext.java:869) ~[spring-context-5.0.5.RELEASE.jar:5.0.5.RELEASE]
	at org.springframework.context.support.AbstractApplicationContext.refresh(AbstractApplicationContext.java:550) ~[spring-context-5.0.5.RELEASE.jar:5.0.5.RELEASE]
	at org.springframework.boot.web.servlet.context.ServletWebServerApplicationContext.refresh(ServletWebServerApplicationContext.java:140) ~[spring-boot-2.0.1.RELEASE.jar:2.0.1.RELEASE]
	at org.springframework.boot.SpringApplication.refresh(SpringApplication.java:759) [spring-boot-2.0.1.RELEASE.jar:2.0.1.RELEASE]
	at org.springframework.boot.SpringApplication.refreshContext(SpringApplication.java:395) [spring-boot-2.0.1.RELEASE.jar:2.0.1.RELEASE]
	at org.springframework.boot.SpringApplication.run(SpringApplication.java:327) [spring-boot-2.0.1.RELEASE.jar:2.0.1.RELEASE]
	at org.springframework.boot.SpringApplication.run(SpringApplication.java:1255) [spring-boot-2.0.1.RELEASE.jar:2.0.1.RELEASE]
	at org.springframework.boot.SpringApplication.run(SpringApplication.java:1243) [spring-boot-2.0.1.RELEASE.jar:2.0.1.RELEASE]
	at com.stylefeng.guns.rest.CinemaApplication.main(CinemaApplication.java:12) [classes/:na]
Caused by: org.springframework.beans.factory.UnsatisfiedDependencyException: Error creating bean with name 'moocCinemaTMapper' defined in file [/Users/Mccree/projects/meeting-film/guns-cinema/target/classes/com/stylefeng/guns/rest/common/persistence/dao/MoocCinemaTMapper.class]: Unsatisfied dependency expressed through bean property 'sqlSessionFactory'; nested exception is org.springframework.beans.factory.BeanCreationException: Error creating bean with name 'sqlSessionFactory' defined in class path resource [com/baomidou/mybatisplus/spring/boot/starter/MybatisPlusAutoConfiguration.class]: Bean instantiation via factory method failed; nested exception is org.springframework.beans.BeanInstantiationException: Failed to instantiate [org.apache.ibatis.session.SqlSessionFactory]: Factory method 'sqlSessionFactory' threw exception; nested exception is com.baomidou.mybatisplus.exceptions.MybatisPlusException: Error: GlobalConfigUtils setMetaData Fail !  Cause:java.sql.SQLException: The connection property 'zeroDateTimeBehavior' acceptable values are: 'CONVERT_TO_NULL', 'EXCEPTION' or 'ROUND'. The value 'convertToNull' is not acceptable.
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.autowireByType(AbstractAutowireCapableBeanFactory.java:1439) ~[spring-beans-5.0.5.RELEASE.jar:5.0.5.RELEASE]
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.populateBean(AbstractAutowireCapableBeanFactory.java:1326) ~[spring-beans-5.0.5.RELEASE.jar:5.0.5.RELEASE]
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.doCreateBean(AbstractAutowireCapableBeanFactory.java:578) ~[spring-beans-5.0.5.RELEASE.jar:5.0.5.RELEASE]
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.createBean(AbstractAutowireCapableBeanFactory.java:501) ~[spring-beans-5.0.5.RELEASE.jar:5.0.5.RELEASE]
	at org.springframework.beans.factory.support.AbstractBeanFactory.lambda$doGetBean$0(AbstractBeanFactory.java:317) ~[spring-beans-5.0.5.RELEASE.jar:5.0.5.RELEASE]
	at org.springframework.beans.factory.support.DefaultSingletonBeanRegistry.getSingleton(DefaultSingletonBeanRegistry.java:228) ~[spring-beans-5.0.5.RELEASE.jar:5.0.5.RELEASE]
	at org.springframework.beans.factory.support.AbstractBeanFactory.doGetBean(AbstractBeanFactory.java:315) ~[spring-beans-5.0.5.RELEASE.jar:5.0.5.RELEASE]
	at org.springframework.beans.factory.support.AbstractBeanFactory.getBean(AbstractBeanFactory.java:199) ~[spring-beans-5.0.5.RELEASE.jar:5.0.5.RELEASE]
	at org.springframework.beans.factory.config.DependencyDescriptor.resolveCandidate(DependencyDescriptor.java:251) ~[spring-beans-5.0.5.RELEASE.jar:5.0.5.RELEASE]
	at org.springframework.beans.factory.support.DefaultListableBeanFactory.doResolveDependency(DefaultListableBeanFactory.java:1138) ~[spring-beans-5.0.5.RELEASE.jar:5.0.5.RELEASE]
	at org.springframework.beans.factory.support.DefaultListableBeanFactory.resolveDependency(DefaultListableBeanFactory.java:1065) ~[spring-beans-5.0.5.RELEASE.jar:5.0.5.RELEASE]
	at org.springframework.beans.factory.annotation.AutowiredAnnotationBeanPostProcessor$AutowiredFieldElement.inject(AutowiredAnnotationBeanPostProcessor.java:584) ~[spring-beans-5.0.5.RELEASE.jar:5.0.5.RELEASE]
	... 19 common frames omitted
Caused by: org.springframework.beans.factory.BeanCreationException: Error creating bean with name 'sqlSessionFactory' defined in class path resource [com/baomidou/mybatisplus/spring/boot/starter/MybatisPlusAutoConfiguration.class]: Bean instantiation via factory method failed; nested exception is org.springframework.beans.BeanInstantiationException: Failed to instantiate [org.apache.ibatis.session.SqlSessionFactory]: Factory method 'sqlSessionFactory' threw exception; nested exception is com.baomidou.mybatisplus.exceptions.MybatisPlusException: Error: GlobalConfigUtils setMetaData Fail !  Cause:java.sql.SQLException: The connection property 'zeroDateTimeBehavior' acceptable values are: 'CONVERT_TO_NULL', 'EXCEPTION' or 'ROUND'. The value 'convertToNull' is not acceptable.
	at org.springframework.beans.factory.support.ConstructorResolver.instantiateUsingFactoryMethod(ConstructorResolver.java:587) ~[spring-beans-5.0.5.RELEASE.jar:5.0.5.RELEASE]
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.instantiateUsingFactoryMethod(AbstractAutowireCapableBeanFactory.java:1250) ~[spring-beans-5.0.5.RELEASE.jar:5.0.5.RELEASE]
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.createBeanInstance(AbstractAutowireCapableBeanFactory.java:1099) ~[spring-beans-5.0.5.RELEASE.jar:5.0.5.RELEASE]
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.doCreateBean(AbstractAutowireCapableBeanFactory.java:541) ~[spring-beans-5.0.5.RELEASE.jar:5.0.5.RELEASE]
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.createBean(AbstractAutowireCapableBeanFactory.java:501) ~[spring-beans-5.0.5.RELEASE.jar:5.0.5.RELEASE]
	at org.springframework.beans.factory.support.AbstractBeanFactory.lambda$doGetBean$0(AbstractBeanFactory.java:317) ~[spring-beans-5.0.5.RELEASE.jar:5.0.5.RELEASE]
	at org.springframework.beans.factory.support.DefaultSingletonBeanRegistry.getSingleton(DefaultSingletonBeanRegistry.java:228) ~[spring-beans-5.0.5.RELEASE.jar:5.0.5.RELEASE]
	at org.springframework.beans.factory.support.AbstractBeanFactory.doGetBean(AbstractBeanFactory.java:315) ~[spring-beans-5.0.5.RELEASE.jar:5.0.5.RELEASE]
	at org.springframework.beans.factory.support.AbstractBeanFactory.getBean(AbstractBeanFactory.java:199) ~[spring-beans-5.0.5.RELEASE.jar:5.0.5.RELEASE]
	at org.springframework.beans.factory.config.DependencyDescriptor.resolveCandidate(DependencyDescriptor.java:251) ~[spring-beans-5.0.5.RELEASE.jar:5.0.5.RELEASE]
	at org.springframework.beans.factory.support.DefaultListableBeanFactory.doResolveDependency(DefaultListableBeanFactory.java:1138) ~[spring-beans-5.0.5.RELEASE.jar:5.0.5.RELEASE]
	at org.springframework.beans.factory.support.DefaultListableBeanFactory.resolveDependency(DefaultListableBeanFactory.java:1065) ~[spring-beans-5.0.5.RELEASE.jar:5.0.5.RELEASE]
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.autowireByType(AbstractAutowireCapableBeanFactory.java:1424) ~[spring-beans-5.0.5.RELEASE.jar:5.0.5.RELEASE]
	... 30 common frames omitted
Caused by: org.springframework.beans.BeanInstantiationException: Failed to instantiate [org.apache.ibatis.session.SqlSessionFactory]: Factory method 'sqlSessionFactory' threw exception; nested exception is com.baomidou.mybatisplus.exceptions.MybatisPlusException: Error: GlobalConfigUtils setMetaData Fail !  Cause:java.sql.SQLException: The connection property 'zeroDateTimeBehavior' acceptable values are: 'CONVERT_TO_NULL', 'EXCEPTION' or 'ROUND'. The value 'convertToNull' is not acceptable.
	at org.springframework.beans.factory.support.SimpleInstantiationStrategy.instantiate(SimpleInstantiationStrategy.java:185) ~[spring-beans-5.0.5.RELEASE.jar:5.0.5.RELEASE]
	at org.springframework.beans.factory.support.ConstructorResolver.instantiateUsingFactoryMethod(ConstructorResolver.java:579) ~[spring-beans-5.0.5.RELEASE.jar:5.0.5.RELEASE]
	... 42 common frames omitted
Caused by: com.baomidou.mybatisplus.exceptions.MybatisPlusException: Error: GlobalConfigUtils setMetaData Fail !  Cause:java.sql.SQLException: The connection property 'zeroDateTimeBehavior' acceptable values are: 'CONVERT_TO_NULL', 'EXCEPTION' or 'ROUND'. The value 'convertToNull' is not acceptable.
	at com.baomidou.mybatisplus.toolkit.GlobalConfigUtils.setMetaData(GlobalConfigUtils.java:196) ~[mybatis-plus-support-2.3.jar:na]
	at com.baomidou.mybatisplus.spring.MybatisSqlSessionFactoryBean.buildSqlSessionFactory(MybatisSqlSessionFactoryBean.java:560) ~[mybatis-plus-core-2.3.jar:na]
	at com.baomidou.mybatisplus.spring.MybatisSqlSessionFactoryBean.afterPropertiesSet(MybatisSqlSessionFactoryBean.java:385) ~[mybatis-plus-core-2.3.jar:na]
	at com.baomidou.mybatisplus.spring.MybatisSqlSessionFactoryBean.getObject(MybatisSqlSessionFactoryBean.java:608) ~[mybatis-plus-core-2.3.jar:na]
	at com.baomidou.mybatisplus.spring.boot.starter.MybatisPlusAutoConfiguration.sqlSessionFactory(MybatisPlusAutoConfiguration.java:147) ~[mybatisplus-spring-boot-starter-1.0.5.jar:na]
	at com.baomidou.mybatisplus.spring.boot.starter.MybatisPlusAutoConfiguration$$EnhancerBySpringCGLIB$$8c0d204b.CGLIB$sqlSessionFactory$0(<generated>) ~[mybatisplus-spring-boot-starter-1.0.5.jar:na]
	at com.baomidou.mybatisplus.spring.boot.starter.MybatisPlusAutoConfiguration$$EnhancerBySpringCGLIB$$8c0d204b$$FastClassBySpringCGLIB$$8027c3cc.invoke(<generated>) ~[mybatisplus-spring-boot-starter-1.0.5.jar:na]
	at org.springframework.cglib.proxy.MethodProxy.invokeSuper(MethodProxy.java:228) ~[spring-core-5.0.5.RELEASE.jar:5.0.5.RELEASE]
	at org.springframework.context.annotation.ConfigurationClassEnhancer$BeanMethodInterceptor.intercept(ConfigurationClassEnhancer.java:361) ~[spring-context-5.0.5.RELEASE.jar:5.0.5.RELEASE]
	at com.baomidou.mybatisplus.spring.boot.starter.MybatisPlusAutoConfiguration$$EnhancerBySpringCGLIB$$8c0d204b.sqlSessionFactory(<generated>) ~[mybatisplus-spring-boot-starter-1.0.5.jar:na]
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method) ~[na:1.8.0_111]
	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62) ~[na:1.8.0_111]
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43) ~[na:1.8.0_111]
	at java.lang.reflect.Method.invoke(Method.java:498) ~[na:1.8.0_111]
	at org.springframework.beans.factory.support.SimpleInstantiationStrategy.instantiate(SimpleInstantiationStrategy.java:154) ~[spring-beans-5.0.5.RELEASE.jar:5.0.5.RELEASE]
	... 43 common frames omitted
```