package org.sparsh.arth.tm


import java.text.SimpleDateFormat

import org.sparsh.Tenant
import org.sparsh.TenantConfig
import org.sparsh.TenantConfigConstants
import org.sparsh.User
import org.sparsh.arth.hr.Employee
import org.sparsh.arth.hr.EmployeeLeaveTransaction
import org.sparsh.arth.hr.EmployeePoC
import org.sparsh.arth.hr.PublicHoliday
import org.sparsh.arth.pm.ProjectResource
import org.sparsh.arth.wf.ApprovalTask
import org.sparsh.arth.wf.Notification
import org.springframework.dao.DataIntegrityViolationException
import org.springframework.security.access.annotation.Secured

class TimeSheetGroupController {

	/**
	 * Dependency injection for the springSecurityService.
	 */
	def springSecurityService
	
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
	
	@Secured(["ROLE_EMPLOYEE"])
    def index() {
        redirect(action: "list", params: params)
    }

	@Secured(["ROLE_EMPLOYEE"])
    def list(Integer max) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
        def employeeInstance = Employee.findByUser(loggedInUser)
        
        params.max = Math.min(max ?: 10, 100)
        [timeSheetGroupInstanceList: TimeSheetGroup.findAllByTenantAndEmployee(loggedInUser.tenant,employeeInstance,params), timeSheetGroupInstanceTotal: TimeSheetGroup.countByTenantAndEmployee(loggedInUser.tenant,employeeInstance), loggedInUser: loggedInUser]
    }
    
    @Secured(["ROLE_EMPLOYEE"])
    def chooseTimeSheet() {
        def loggedInUser =  User.get(springSecurityService.currentUser.id)
        def employeeInstance = Employee.findByUser(loggedInUser)
        
        def timeSheetInstance = new TimeSheet(params)
        timeSheetInstance.employee = employeeInstance
        
        def rangeAllowed = Integer.parseInt(TenantConfig.findByTenantAndName(loggedInUser.tenant,TenantConfigConstants.ADVANCE_TIMESHEET_ALLOWED_DAYS).value.toString()).intValue()
        def workingDays = TenantConfig.findByTenantAndName(loggedInUser.tenant,TenantConfigConstants.WORKING_DAYS).value.toString().split(",")
        
        if(params.chooseTimeSheet){
            if(!(params.startDate) || !(params.endDate)){
                flash.message = 'Please select a week.'
            }else{
                SimpleDateFormat formatter = new SimpleDateFormat("MM/dd/yyyy");
                Date dateStr = formatter.parse(params.startDate);
                Calendar c = Calendar.getInstance();
                c.setTime(new Date());
                 
                c.add(Calendar.DATE, rangeAllowed);
                if(dateStr.after(c.getTime())){
                    flash.message = 'You are allowed to select only ' + rangeAllowed + ' days in advance.'
                }else{
                    if(TimeSheet.findByEmployeeAndWeekStartDate(employeeInstance,dateStr)){
                        flash.message = 'TimeSheet is already exist for selected week starting ' + dateStr
                    }else{
                        timeSheetInstance.weekStartDate = dateStr
                        flash.message = 'You have selected week starting ' + dateStr                        
                        def dayNames = message(code: 'default.day.names').split(",")
                        
                        //get dates in this week which are holidays
                        def query = PublicHoliday.where{holidayDate >= dateStr && holidayDate <= getLastday(dateStr) }
                        def pubHoli = query.findAll()
                        render(view: "create", model: [timeSheetInstance:timeSheetInstance, loggedInUser:loggedInUser, dateSet:getWeekDates(dateStr), dayNames:dayNames, workingDays:workingDays, pubHoli:pubHoli])
                        return
                    }
                }
            }
        }
        [timeSheetInstance: timeSheetInstance, loggedInUser: loggedInUser, rangeAllowed:rangeAllowed]
    }

	@Secured(["ROLE_EMPLOYEE"])
    def save() {
        def loggedInUser =  User.get(springSecurityService.currentUser.id)
        def employeeInstance = Employee.findByUser(loggedInUser)
        
        def timeSheetGroupInstance = new TimeSheetGroup(params)
        timeSheetGroupInstance.tenant = loggedInUser.tenant
        
        def totalHrs = 0
        for(ProjectResource pr:ProjectResource.findAllByUser(employeeInstance)){
            def timeSheetInstance = new TimeSheet(params)
            timeSheetInstance.tenant = loggedInUser.tenant
            timeSheetInstance.employee = employeeInstance
            timeSheetInstance.status = 'Saved'
            timeSheetInstance.project = pr?.project
            
            //read additional params
            timeSheetInstance.day1 = (params.get(pr.id + ':key:1') == null)? 0 : Integer.parseInt(params.get(pr.id + ':key:1')).intValue()
            timeSheetInstance.day2 = (params.get(pr.id + ':key:2') == null)? 0 : Integer.parseInt(params.get(pr.id + ':key:2')).intValue()
            timeSheetInstance.day3 = (params.get(pr.id + ':key:3') == null)? 0 : Integer.parseInt(params.get(pr.id + ':key:3')).intValue()
            timeSheetInstance.day4 = (params.get(pr.id + ':key:4') == null)? 0 : Integer.parseInt(params.get(pr.id + ':key:4')).intValue()
            timeSheetInstance.day5 = (params.get(pr.id + ':key:5') == null)? 0 : Integer.parseInt(params.get(pr.id + ':key:5')).intValue()
            timeSheetInstance.day6 = (params.get(pr.id + ':key:6') == null)? 0 : Integer.parseInt(params.get(pr.id + ':key:6')).intValue()
            timeSheetInstance.day7 = (params.get(pr.id + ':key:7') == null)? 0 : Integer.parseInt(params.get(pr.id + ':key:7')).intValue()
            
            totalHrs = totalHrs+timeSheetInstance.day1+timeSheetInstance.day2+timeSheetInstance.day3+timeSheetInstance.day4+timeSheetInstance.day5+timeSheetInstance.day6+timeSheetInstance.day7
            
            if (!timeSheetInstance.save(flush: true)) {
                def rangeAllowed = Integer.parseInt(TenantConfig.findByTenantAndName(tenant,TenantConfigConstants.ADVANCE_TIMESHEET_ALLOWED_DAYS).value.toString()).intValue()
                render(view: "create", model: [timeSheetGroupInstance: timeSheetGroupInstance, loggedInUser: loggedInUser, rangeAllowed:rangeAllowed])
                return
            }
        }
        
        
        timeSheetGroupInstance.employee = employeeInstance
        timeSheetGroupInstance.status = 'Saved'
        timeSheetGroupInstance.totalHrs = totalHrs
        timeSheetGroupInstance.weekEndDate = getLastday(timeSheetGroupInstance.weekStartDate)
        timeSheetGroupInstance.save(flush: true)
        

        flash.message = message(code: 'default.created.message', args: [message(code: 'timeSheetGroup.label', default: 'TimeSheetGroup'), timeSheetGroupInstance.id])
        redirect(action: "show", id: timeSheetGroupInstance.id)
    }

	@Secured(["ROLE_EMPLOYEE"])
    def show(Long id) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		
        def timeSheetGroupInstance = TimeSheetGroup.get(id)
        if (!timeSheetGroupInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'timeSheetGroup.label', default: 'TimeSheetGroup'), id])
            redirect(action: "list")
            return
        }else if(timeSheetGroupInstance.tenant != loggedInUser.tenant){
			flash.message = message(code: 'springSecurity.denied.message')
			redirect(action: "list")
			return
        }
        def dayNames = message(code: 'default.day.names').split(",")
        [timeSheetGroupInstance: timeSheetGroupInstance, loggedInUser: loggedInUser,dateSet:getWeekDates(timeSheetGroupInstance.weekStartDate), dayNames:dayNames]
    }

	@Secured(["ROLE_EMPLOYEE"])
    def submitForApproval(Long id) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
        def employeeInstance = Employee.findByUser(loggedInUser)
        
        def timeSheetGroupInstance = TimeSheetGroup.get(id)
        if (!timeSheetGroupInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'timeSheetGroup.label', default: 'TimeSheetGroup'), id])
            redirect(action: "list")
            return
        }else if(timeSheetGroupInstance.tenant != loggedInUser.tenant){
			flash.message = message(code: 'springSecurity.denied.message')
			redirect(action: "list")
			return
        }else if(timeSheetGroupInstance.employee != employeeInstance){
            flash.message = message(code: 'springSecurity.denied.message')
            redirect(action: "list")
            return
        }else if(timeSheetGroupInstance.status != 'Saved'){
            flash.message = 'You can not re-submit this request.'
            redirect(action: "list")
            return
        }
        
        def employeePoCInstance = EmployeePoC.findByEmployee(employeeInstance)
        //check if employee have POC
        if(!employeePoCInstance){
            flash.message = 'Your Point of Contact are not available. Contact Administrator.'
            redirect(action: "show", id: timeSheetGroupInstance.id)
            return
        }else{
            //read system value
            def confVal = TenantConfig.findByTenantAndName(loggedInUser.tenant,TenantConfigConstants.TIMESHEET_APPROVAL).value.toString().split(",")
            for(String s: confVal){
                if('HRPOC'.equalsIgnoreCase(s)){
                    def approvalTaskInstance = new ApprovalTask(type:'TIMESHEET',requestor:employeeInstance, requestDate:new Date(), tenant:loggedInUser.tenant)
                    approvalTaskInstance.message = message(code: 'default.timesheet.request', args:[employeeInstance,timeSheetGroupInstance.weekStartDate,timeSheetGroupInstance.weekEndDate])
                    approvalTaskInstance.approver = employeePoCInstance?.hrPoC
                    approvalTaskInstance.remoteId = timeSheetGroupInstance.id
                    approvalTaskInstance.save(flush:true)
                    new Notification(employee:approvalTaskInstance.approver, message:approvalTaskInstance.message, tenant:loggedInUser.tenant).save(flush:true)
                }else if('PRPOC'.equalsIgnoreCase(s)){
                    def approvalTaskInstance = new ApprovalTask(type:'TIMESHEET',requestor:employeeInstance, requestDate:new Date(), tenant:loggedInUser.tenant)
                    approvalTaskInstance.message = message(code: 'default.timesheet.request', args:[employeeInstance,timeSheetGroupInstance.weekStartDate,timeSheetGroupInstance.weekEndDate])
                    approvalTaskInstance.approver = employeePoCInstance?.projectPoC
                    approvalTaskInstance.remoteId = timeSheetGroupInstance.id
                    approvalTaskInstance.save(flush:true)
                    new Notification(employee:approvalTaskInstance.approver, message:approvalTaskInstance.message, tenant:loggedInUser.tenant).save(flush:true)
                }
            }
            timeSheetGroupInstance.status = 'Submitted'
            timeSheetGroupInstance.save(flush:true)
       }

        redirect(action: "show", id: timeSheetGroupInstance.id)
    }

	@Secured(["ROLE_EMPLOYEE"])
    def delete(Long id) {
		def loggedInUser =  User.get(springSecurityService.currentUser.id)
		def employeeInstance = Employee.findByUser(loggedInUser)
        
        def timeSheetGroupInstance = TimeSheetGroup.get(id)
        if (!timeSheetGroupInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'timeSheetGroup.label', default: 'TimeSheetGroup'), id])
            redirect(action: "list")
            return
        }else if(timeSheetGroupInstance.tenant != loggedInUser.tenant){
			flash.message = message(code: 'springSecurity.denied.message')
			redirect(action: "list")
			return
        }else if(timeSheetGroupInstance.employee != employeeInstance){
            flash.message = message(code: 'springSecurity.denied.message')
            redirect(action: "list")
            return
        }else if(!timeSheetGroupInstance.status.equalsIgnoreCase("Saved")){
            flash.message = 'You cannot delete this timesheet.'
            redirect(action: "list")
            return
        }
        
        try {
            //delete timesheets first
            def tmplist = TimeSheet.findAllByEmployeeAndWeekStartDate(employeeInstance,timeSheetGroupInstance.weekStartDate)
            for(TimeSheet ts:tmplist){
                ts.delete(flush: true)
            }
            timeSheetGroupInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'timeSheetGroup.label', default: 'TimeSheetGroup'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'timeSheetGroup.label', default: 'TimeSheetGroup'), id])
            redirect(action: "show", id: id)
        }
    }
    
    public static Date getFirstDayOfTheWeek(Date date){
        // set the date
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);

        // "calculate" the start date of the week
        Calendar first = (Calendar) cal.clone();
        first.add(Calendar.DAY_OF_WEEK,first.getFirstDayOfWeek() - first.get(Calendar.DAY_OF_WEEK));
        
        return first.getTime();
    }
    
    public static Set<Date> getWeekDates(Date date){
        Date tmp = getFirstDayOfTheWeek(date);
        Set<Date> dateSet = new LinkedHashSet<Date>();
        dateSet.add(tmp);
        Calendar tmpCal = Calendar.getInstance();
        tmpCal.setTime(tmp);
        for(int i=1; i<=6; i++){
            tmpCal.add(Calendar.DAY_OF_YEAR, 1);
            dateSet.add(tmpCal.getTime());
        }
        
        return dateSet;
    }
    
    public static Date getLastday(Date date){
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.add(Calendar.DAY_OF_YEAR, 6);
        return cal.getTime();
    }
    
    public static void complexLeaveTimeSheetGeneration(EmployeeLeaveTransaction elt){
        def dateStr = getFirstDayOfTheWeek(elt.startDate)
        def tenant = elt.tenant
        def employee = elt.employee
        //my record
        def leaveTimeSheet = LeaveTimeSheet.findByEmployeeAndWeekStartDate(employee,dateStr)? LeaveTimeSheet.findByEmployeeAndWeekStartDate(employee,dateStr) : new LeaveTimeSheet(tenant:tenant, weekStartDate:dateStr, employee:employee, status:'Saved')
        def isCapsuleWeekEnd = Boolean.parseBoolean(TenantConfig.findByTenantAndName(tenant,TenantConfigConstants.CAPSULE_WEEKENDS).value.toString())
        def workingHrs = Integer.parseInt(TenantConfig.findByTenantAndName(tenant,TenantConfigConstants.WORKING_HRS_PER_DAY).value.toString()).intValue()
        
        
        Calendar cal = Calendar.getInstance()
        cal.setTime(elt.startDate)
        def valApplied = elt.appliedHours
        
        while(valApplied > 0){
            def day = cal.get(Calendar.DAY_OF_WEEK)
            if(!isCapsuleWeekEnd){
                while(isWeekEnd(cal.get(Calendar.DAY_OF_WEEK), tenant)){
                    //add one day
                    cal.add(Calendar.DAY_OF_YEAR, 1);
                    if(dateStr.equals(getFirstDayOfTheWeek(cal.getTime()))){
                       continue; 
                    }else{
                        //save first one and create new one
                        leaveTimeSheet.save(flush:true)
                        dateStr = getFirstDayOfTheWeek(cal.getTime())
                        leaveTimeSheet = LeaveTimeSheet.findByEmployeeAndWeekStartDate(employee,dateStr)? LeaveTimeSheet.findByEmployeeAndWeekStartDate(employee,dateStr) : new LeaveTimeSheet(tenant:tenant, weekStartDate:dateStr, employee:employee, status:'Saved')
                        
                    }
                }
            }
            if(valApplied <= workingHrs){
                setValueInCol(leaveTimeSheet, cal.get(Calendar.DAY_OF_WEEK), valApplied)
                valApplied = 0
            }else{
                //other loop
                setValueInCol(leaveTimeSheet, cal.get(Calendar.DAY_OF_WEEK), workingHrs)
                cal.add(Calendar.DAY_OF_YEAR, 1);
                valApplied = valApplied - workingHrs
            }
        }
        leaveTimeSheet.save(flush:true)            
        
    }
    
    private static void setValueInCol(LeaveTimeSheet lts, int day, int val){
        switch(day){
            case 1:
            lts.day1 = lts.day1 + val
            break;
            case 2:
            lts.day2 = lts.day2+val
            break;
            case 3:
            lts.day3 = lts.day3+val
            break;
            case 4:
            lts.day4 = lts.day4+val
            break;
            case 5:
            lts.day5 = lts.day5+val
            break;
            case 6:
            lts.day6 = lts.day6+val
            break;
            case 7:
            lts.day7 = lts.day7+val
            break;
        }
    }
    
    private static boolean isWeekEnd(int val, Tenant tenant){
        def workingDays = TenantConfig.findByTenantAndName(tenant,TenantConfigConstants.WORKING_DAYS).value.toString().split(",")
        def isWeekEnd = true
        for(String s: workingDays){
           if(val == Integer.parseInt(s).intValue()){
               isWeekEnd = false              
           } 
        }
        
        return isWeekEnd
    }
}
