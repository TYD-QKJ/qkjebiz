package org.iweb.sys;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.activiti.engine.ProcessEngine;
import org.activiti.engine.ProcessEngines;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.repository.ProcessDefinitionQuery;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import com.qkj.manage.domain.VacationForm;
public class ActivitiUtil {
	private final static String url = "com/qkj/activiti/";
	private ProcessEngine engine=null;
	private RepositoryService repositoryService=null;
	private RuntimeService runtimeService=null;
	private TaskService taskservice=null;
	public static void main(String[] args) {
		VacationForm v=new VacationForm();
		v.setStartDate("2015-7-6");
		v.setEndDate("2015-7-8");
		v.setDays(4);
		v.setVacationType(1);
		v.setReason("HAOBA");
		ActivitiUtil f=new ActivitiUtil();
        f.startVacation("Vacation");
	    /*String taskid=f.newtask(v);
        f.upAssignee(taskid,"安旭旺1");*/
        f.newtask(v);
	}
	// 启动请假流程
			public Object startVacation(String CategoryName) {
				// 设置标题
				engine = ProcessEngines.getDefaultProcessEngine();
				// 得到流程存储服务实例
				repositoryService = engine.getRepositoryService();
				// 得到运行时服务组件
				 runtimeService = engine.getRuntimeService();
				// 部署流程描述文件
			    taskservice=engine.getTaskService();
				List<Task> list=teskCount(taskservice);
				for (Task task : list) {
					System.out.println(task.getId());
				}
			/*	List<Task> tasks = taskService.createTaskQuery().taskCandidateGroup("sales").list();
		for (Task task : tasks) {
			  System.out.println("Following task is available for sales group: " + task.getName());
		      }*/
				/*
				// 查找流程定义
	     	    ProcessDefinitionQuery processDefinitionQuery = repositoryService.createProcessDefinitionQuery();
				ProcessDefinition pd=processDefinitionQuery.processDefinitionKey("Vacation").list().get(0);
				// 初始化任务参数
	     		Map<String, Object> vars = new HashMap<String, Object>();
				vars.put("arg", object);
				// 启动流程
				ProcessInstance pi = runtimeService.startProcessInstanceByKey(pd
						.getKey());
					// 查询第一个任务
					Task firstTask = taskservice.createTaskQuery()
						.processInstanceId("1105").singleResult();
				// 设置任务受理人
				taskservice.setAssignee(firstTask.getId(), object.getUserId());
				
				// 完成任务
				taskservice.complete(firstTask.getId(), vars);	
				// 记录请假数据
				System.out.println(	task.getId()+"==========================");
				Task firstTask = taskservice.createTaskQuery()
						.processInstanceId(pi.getId()).singleResult();
				System.out.println(firstTask.getId()+"=================");
				taskservice.setOwner(firstTask.getId(), "张三");
				//saveVacation(vacation, pi.getId());
				//taskservice.setOwner(firstTask.getId(), "张三");
	*/		return null;
			}
			//新建任务
			private String newtask(Object object) {
				// 查找流程定义
	     	    ProcessDefinitionQuery processDefinitionQuery = repositoryService.createProcessDefinitionQuery();
				ProcessDefinition pd=processDefinitionQuery.processDefinitionKey("Vacation").list().get(0);
				// 初始化任务参数
	     		Map<String, Object> vars = new HashMap<String, Object>();
				vars.put("arg", object);
				// 启动流程
			/*	ProcessInstance pi = runtimeService.startProcessInstanceByKey(pd
						.getKey());*/
				 String[] assigneeList={"0","1","2","3"};
					Map<String, Object> processInstVar = new HashMap<String, Object>();
					//必须是List
					processInstVar.put("assigneeList", Arrays.asList(assigneeList));
					processInstVar.put("signCount", 0);
					ProcessInstance pi=runtimeService.startProcessInstanceByKey(pd
							.getKey(), processInstVar);
					
					
				Task task=taskservice.createTaskQuery().executionId(pi.getId()).singleResult();
				System.out.println(task.getId());
				return pi.getId();
				}
			//设置任务受理人
			private void upAssignee(String firstid,String userid) {
				taskservice.setAssignee(firstid, userid);
				}
			//获取指定用户持有的任务
			private List<Task> teskCount(TaskService taskservice) {
				List<Task> list =taskservice.createTaskQuery().taskOwner("张三").list();
				return list;
				}
			//部署新的流程
	                private void newbpmn(String CategoryName) {
		                 repositoryService.createDeployment()
		                 .addClasspathResource("com/qkj/activiti/"+CategoryName+".bpmn").deploy();
				}
	                //任务通过
	                private void through(String taskId,Map vars) {
	                	taskservice.complete(taskId, vars);	
				}
}
