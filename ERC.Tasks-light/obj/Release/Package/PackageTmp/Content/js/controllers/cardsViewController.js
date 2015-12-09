
app.controller("cardsViewController", function ($scope, $filter, ERCTask_Service) {
    $scope.selection = []; // scope for contain all checked element
    $scope.AdminUserList = []; // scope for hold track Admin and User Id
    $scope.AdminUser = []; // scope for hold as of  track Admin and User Id
    $scope.Options = { showOptions: false }; // scope for toggle
    $scope.countUsers = { count: 0 }; //scope  for count total checked user
    $scope.Login = { userName: "", password: "" };//Login Credential
    $scope.ERC = { Tasks: "" }; // scope for Task
    $scope.ERC_Day = { PerDayTask: "" }; // scope for Per Day Task
    $scope.ERC_Load = { loading: false }; // scope for loading 
    $scope.MarkComplete = { mark: 0 }; // scope for mark
    //$scope.MeetingHistory = { Description: "", DescriptionDate: "" }; // scope for Meeting History
    $scope.UserIdForCheck = { id: "" };// for checking that admin/manager
    //scope for ERCCalender of task detail
    $scope.ERCCalendar = {
        CalendarTaskDetailTaskname: "",
        CalendarTaskDetailTaskDesc: "",
        CalendarTaskDetailTaskDueHour: "",
        CalendarTaskDetailTaskDueMinutes: "",
        CalendarTaskDetailRecurrencePatternMsg: "",
        CalendarTaskDetailDescription: "",
        Customer: "",
        CreatedDate:""
    };
    $scope.Register = {
        UserId:"",
        UserRole:"",
        UserName:"",
        DisplayName:"",
        Email: "",
        Password:"",
        CreatedDate:""
    };

    //get all task from api and populate into Task scope   
    //data source for minute drop down in task/sub task creation
    $scope.Minute = [{ "Min": "0" }, { "Min": "1" }, { "Min": "2" }, { "Min": "3" }, { "Min": "4" }, { "Min": "5" }, { "Min": "6" }, { "Min": "7" }, { "Min": "8" }, { "Min": "9" }, { "Min": "10" }, { "Min": "11" }, { "Min": "12" }, { "Min": "13" }, { "Min": "14" }, { "Min": "15" }, { "Min": "16" }, { "Min": "17" }, { "Min": "18" }, { "Min": "19" }, { "Min": "20" }, { "Min": "21" }, { "Min": "22" }, { "Min": "23" }, { "Min": "24" }, { "Min": "25" }, { "Min": "26" }, { "Min": "27" }, { "Min": "28" }, { "Min": "29" }, { "Min": "30" }, { "Min": "31" }, { "Min": "32" }, { "Min": "33" }, { "Min": "34" }, { "Min": "35" }, { "Min": "36" }, { "Min": "37" }, { "Min": "38" }, { "Min": "39" }, { "Min": "40" }, { "Min": "41" }, { "Min": "42" }, { "Min": "43" }, { "Min": "44" }, { "Min": "45" }, { "Min": "46" }, { "Min": "47" }, { "Min": "48" }, { "Min": "49" }, { "Min": "50" }, { "Min": "51" }, { "Min": "52" }, { "Min": "53" }, { "Min": "54" }, { "Min": "55" }, { "Min": "56" }, { "Min": "57" }, { "Min": "58" }, { "Min": "59" }];
    //data source for hour drop down in task/sub task creation
    $scope.Hour = [{ "Hour": "0" }, { "Hour": "1" }, { "Hour": "2" }, { "Hour": "3" }, { "Hour": "4" }, { "Hour": "5" }, { "Hour": "6" }, { "Hour": "7" }, { "Hour": "8" }, { "Hour": "9" }, { "Hour": "10" }, { "Hour": "11" }, { "Hour": "12" }, { "Hour": "13" }, { "Hour": "14" }, { "Hour": "15" }, { "Hour": "16" }, { "Hour": "17" }, { "Hour": "18" }, { "Hour": "19" }, { "Hour": "20" }, { "Hour": "21" }, { "Hour": "22" }, { "Hour": "23" }, { "Hour": "24" }];
    $scope.Pattern = [{ "Name": "Daily" }, { "Name": "Weekly" }, { "Name": "Monthly" }];
    $scope.PatternRecurrence = [{ "Name": "Daily", "Pattern": "Daily", "id": "0" }, { "Name": "Every first", "Pattern": "Weekly", "id": "0" }, { "Name": "Every second", "Pattern": "Weekly", "id": "1" }, { "Name": "Every third", "Pattern": "Weekly", "id": "2" }, { "Name": "Every fourth", "Pattern": "Weekly", "id": "3" }, { "Name": "Every fifth", "Pattern": "Weekly", "id": "4" }, { "Name": "Every sixth", "Pattern": "Weekly", "id": "5" }, { "Name": "Sixth from EOW", "Pattern": "Weekly", "id": "6" }, { "Name": "Fifth from EOW", "Pattern": "Weekly", "id": "7" }, { "Name": "Fourth from EOW", "Pattern": "Weekly", "id": "8" }, { "Name": "Third from EOW", "Pattern": "Weekly", "id": "9" }, { "Name": "Second from EOW", "Pattern": "Weekly", "id": "10" }, { "Name": "First from EOW", "Pattern": "Weekly", "id": "11" }, { "Name": "Every first", "Pattern": "Monthly", "id": "0" }, { "Name": "Every second", "Pattern": "Monthly", "id": "1" }, { "Name": "Every third", "Pattern": "Monthly", "id": "2" }, { "Name": "Every fourth", "Pattern": "Monthly", "id": "3" }, { "Name": "Every fifth", "Pattern": "Monthly", "id": "4" }, { "Name": "Every sixth", "Pattern": "Monthly", "id": "5" }, { "Name": "Sixth from EOM", "Pattern": "Monthly", "id": "6" }, { "Name": "Fifth from EOM", "Pattern": "Monthly", "id": "7" }, { "Name": "Fourth from EOM", "Pattern": "Monthly", "id": "8" }, { "Name": "Third from EOM", "Pattern": "Monthly", "id": "9" }, { "Name": "Second from EOM", "Pattern": "Monthly", "id": "10" }, { "Name": "First from EOM", "Pattern": "Monthly", "id": "11" }];
    //data source for week day name
    $scope.WeekDay = [{ "Name": "Sunday", "id": 1 }, { "Name": "Monday", "id": 2 }, { "Name": "Tuesday", "id": 3 }, { "Name": "Wednesday", "id": 4 }, { "Name": "Thursday", "id": 5 }, { "Name": "Friday", "id": 6 }, { "Name": "Saturday", "id": 7 }];
    $scope.Roles = [{ "Name": "admin", "id": 1 }, { "Name": "user", "id": 2 }, { "Name": "manager", "id": 3 }];
    //data source for month name
    $scope.Month = [{ "Name": "January", "id": 1 }, { "Name": "February", "id": 2 }, { "Name": "March", "id": 3 }, { "Name": "April", "id": 4 }, { "Name": "May", "id": 5 }, { "Name": "June", "id": 6 }, { "Name": "July", "id": 7 }, { "Name": "August", "id": 8 }, { "Name": "September", "id": 9 }, { "Name": "October", "id": 10 }, { "Name": "November", "id": 11 }, { "Name": "December", "id": 12 }];
    // get month and year to display the label between left and right arrow
    $scope.CurrentMonth = $scope.Month[(new Date().getMonth())].Name + ' ' + new Date().getFullYear();       
    $scope.RemoveUserId = ""; //used to remove assignment
    $scope.MonthCalendarDay = [];//contain day name for month view calendar
    $scope.PushAssignUser = [];//contain assigned users
    $scope.MonthCalendarDate = new Date();
    MonthDayPush($scope.MonthCalendarDate);//initialize the array with current date
    $scope.PerDayTask = "";//per task for calendar initilization    
    var currentstartofweek = moment().startOf("week");
    var currentendofweek = moment().endOf("week");
    $scope.TaskDetailType = "";//calendar task detail type. used in modal user assignment    
    $scope.TaskID = "";//TaskId assignment on every click of buttons to get the recent TaskId for recent action.    
    $scope.PushTags = [];//Pushing all tags according to it's taskId
    $scope.UsersList = ""; //it contains the list of assigned users
    $scope.NoOfDays = new Date(new Date().getFullYear(), new Date().getMonth(), 0).getDate();
    //this label is used to display the day, week and month
    //in calendar view of task
    $scope.ViewLabel = new Date();
    //get the default current start date of this week
    $scope.currentstartofweek = new Date(currentstartofweek);
    //get the default current end date of this week
    $scope.currentendofweek = new Date(currentendofweek);
    
    //Task control models including add & edit
    $scope.TaskModal = {        
        ercTaskTitle:"",
        ercTaskDesc:"",
        ercSubTaskDuedate:"",
        AdminId:"",
        RecurrenceBusinessDayStep:"",
        RecurrencePattern: "",
        ercTaskTitle1: "",
        ercTaskDesc1: "",
        ercSubTaskDuedate1: "",
        AdminId1: "",
        RecurrenceBusinessDayStep1: "",
        RecurrencePattern1: "",
        customer: "",
        customerEdit: ""
    };
    //enter key press functionality for login button
   
    ERCTask_Service.IsLoggedIn().success(function (data, status) {
        if (data != null) {
            $scope.UserModel = data;
            $scope.DisplayName = data.DisplayName;
            console.log(data);
            GetAdminUsers();
            $scope.UserIdForCheck.id = data.UserId;
            GetAllTaskRecords();
            $scope.UserIdForCheck.id = $scope.UserModel.UserId;
            GetPerMonthTaskForCalendar($scope.MonthCalendarDate, $scope.UserModel.UserId);
            //GetPerTaskforCalendarView(new Date(), $scope.UserModel.UserId);
            GetPerWeekTaskForCalendar($scope.currentstartofweek, new Date(), $scope.UserModel.UserId);
            GetAllUser();
            //$scope.ERC_Load.loading = false;
        }
    }).error(function (data, status) {

    });
    //user's login functionality
    $scope.Login = function () {       
        ERCTask_Service.Login($scope.Login.userName, $scope.Login.password)
            .success(function (data, status) {
                if (data != null) {
                    // alert(JSON.stringify(data));
                    $scope.UserIdForCheck.id = data.UserId;
                    $scope.UserModel = data;
                    $scope.DisplayName = data.DisplayName;
                    GetAllTaskRecords();
                    GetAdminUsers();
                    GetAllUser();
                    GetPerMonthTaskForCalendar($scope.MonthCalendarDate, $scope.UserModel.UserId);
                    //GetPerTaskforCalendarView(new Date(), $scope.UserModel.UserId);
                    GetPerWeekTaskForCalendar($scope.currentstartofweek, new Date(), $scope.UserModel.UserId);
                    console.log(data);
                    $scope.ERC_Load.loading = false;
                } else {
                    $scope.UserStatus = "Username or Password invalid!!!";
                    console.log("Unable to login, please try again.");
                }
            })
            .error(function (data, status) {
                console.log("Unknown error occured when trying to login.");
            });
    }

    //GetAllUser(); 
    //To Get All Users  function 
    function GetAllUser() {
        var promiseget = ERCTask_Service.GetUsers($scope.UserIdForCheck.id);
        promiseget.then(function (pl) {
            if (pl.data != null) {
                $scope.UsersList = pl.data;
               //alert(JSON.stringify($scope.UsersList));
            }
            else {
                console.log("Users not available in database.");
            }
        },
               function (errorpl) {
                   console.log("Error to fetch users.");
               });

    }
    //-------------------------------------
   
    // toggle selection for a given user by name
    $scope.toggleSelection = function toggleSelection(UserId) {
        var idx = $scope.selection.indexOf(UserId);
        // is currently selected
        if (idx > -1) {
            $scope.selection.splice(idx, 1);
        }

            // is newly selected
        else {
            $scope.selection.push(UserId);
        }
    };
    $scope.toggle = function () {
        $scope.Options.showOptions = !$scope.Options.showOptions;
    }
    
     function isSelected(element) { return element; }
    //-------------------------------------
    //method to get the all users in active directory
    //To Get All Task Records  function definition
    function GetAllTaskRecords() {
        $scope.ERC_Load.loading = true;
        var promiseget = ERCTask_Service.getUserTasks($scope.UserModel.UserId);
        promiseget.then(function (pl) {
            $scope.ERC.Tasks = pl.data;            
          // alert(JSON.stringify($scope.ERC.Tasks));
            if (pl.data != null) $scope.ERC.Tasks = pl.data;
            else console.log("Task not associated to you.");
            $scope.ERC_Load.loading = false;
        },
               function (errorpl) {
                   console.log("Error to fetch users.");
               });

    }


    //-------------------------------------    
    //To Get All MeetingHistory  function definition

    //$scope.MeetingHistory = function (adminId) {
    //    //alert(adminId);
    //    $scope.ERC_Load.loading = true;
    //    var promiseget = ERCTask_Service.getMeetingHistory(adminId);
    //    promiseget.then(function (pl) {
    //        $scope.MeetingHistory = pl.data;
    //        GetAllTaskRecords();
    //         //alert(JSON.stringify($scope.MeetingHistory));
    //        if (pl.data != null) $scope.ERC.Tasks = pl.data;
    //        else console.log("You have no Meeting History");
    //        $scope.ERC_Load.loading = false;
    //    },
    //           function (errorpl) {
    //               console.log("Error to fetch users.");
    //           });

    //}
    //CreateUser
    $scope.CreateUser = function () {
      
        var item = {
            UserRole: $scope.Register.UserRole,
            UserName: $scope.Register.UserName,
            DisplayName: $scope.Register.DisplayName,
            Email: $scope.Register.Email,
            Password: $scope.Register.Password
                   
        };
       
        var promisePost = ERCTask_Service.CreateUser(item);
        promisePost.then(function (pl) {
            $scope.Register.UserRole = "";
            $scope.Register.UserName = "";
            $scope.Register.DisplayName = "";
            $scope.Register.Email = "";
            $scope.Register.Password = "";
            //refresh task modals
            GetAllTaskRecords();
            GetAdminUsers();
            GetAllUser();
            item = {};

        }, function (err) {
            console.log("Some error occured.");
        });
    }

    //add new task to database
    //refresh the task modal
    $scope.AddItem = function () {
        var idx = $scope.TaskModal.RecurrenceBusinessDayStep;
        if (idx < 6) idx++;
        else idx = idx - 12;
        var item = {
            TaskName: $scope.TaskModal.ercTaskTitle,
            TaskDesc: $scope.TaskModal.ercTaskDesc,
            TaskDueDate: $scope.TaskModal.ercSubTaskDuedate,
            RecurrenceBusinessDayStep: idx,
            AdminId:$scope.UserModel.UserId,
            RecurrencePattern: $scope.TaskModal.RecurrencePattern,
            Customer:$scope.TaskModal.customer
        };
        //alert(JSON.stringify(item));
        //$scope.Tasks.push(item);  
        var promisePost = ERCTask_Service.AddTask(item);
        promisePost.then(function (pl) {           
            $scope.TaskID = pl.data;
            $scope.TaskModal.ercTaskTitle = "";
            $scope.TaskModal.ercTaskDesc = "";
            $scope.TaskModal.ercSubTaskDuedate = "";
            $scope.TaskModal.TaskDueHour = "";
            $scope.TaskModal.RecurrencePattern = "";
            $scope.TaskModal.customer = "";
            $scope.AssignedToUser();
            //refresh task modals
            GetAllTaskRecords();
            item = {};
           
        }, function (err) {
            console.log("Some error occured.");
        });
    }
    //
    $scope.AssignedToUser = function () {
        $scope.PushAssignUser = [];
        $scope.PushAssignUser.push({
            "UserId": $scope.UserModel.UserId,
            "DisplayName": $scope.UserModel.DisplayName
        });     
        //alert(JSON.stringify($scope.PushAssignUser));
        //we can add the multiple users at a time  
        //populate the $scope.PushAssignUser array and pass to ERCTask_Service.AssignedToUser method
        //if user already associated with the specific task then duplicate record will not inserted.
        var promisePost = ERCTask_Service.AssignedToUser($scope.PushAssignUser, $scope.TaskID);
        promisePost.then(function (pl) {
            GetAllTaskRecords();
            item = {};
        }, function (err) {
            console.log("Error in user assignment.");
        });

    }

    //function to delete the task
    //task id is require to delete
    $scope.removeItem = function () {
            var promiseDelete = ERCTask_Service.DeleteTask($scope.TaskID);
            promiseDelete.then(function (pl) {                
                GetAllTaskRecords();
            }, function (err) {
                 console.log("Some Error Occured.");
            });       
    }
     //this function is call when any modal popup require 
    //assign task id/sub task id to global scope
    $scope.fnPopId = function (id, cat) {
        $scope.TaskID = id;
        $scope.getDetailTaskInfo(id);
        }   
       //this function used for sorting of records in table view
    $scope.sort100 = function (keyname) {
            $scope.columnToOrder = keyname;
            $scope.filteredList = $filter('orderBy')($scope.filteredList, $scope.columnToOrder, $scope.reverse);
            $scope.sortKey = keyname;   //set the sortKey to the param passed 
            $scope.reverse = !$scope.reverse; //if true make it false and vice versa 
        };

    //this is used in the day calendar view of task 
    // call while click on array sign
    $scope.clkArrow = function (id) {
            var dd = new Date($scope.ViewLabel);
            if (id == 1) {
                dd.setDate(dd.getDate() - 1);
                $scope.ViewLabel = dd;
              (GetPerTaskforCalendarView(dd, $scope.UserModel.UserId));
            }
            else if (id == 2) {
                dd.setDate(dd.getDate() + 1);
                $scope.ViewLabel = dd;
                GetPerTaskforCalendarView(dd, $scope.UserModel.UserId);
            }
            else {
                GetPerTaskforCalendarView(dd, $scope.UserModel.UserId);
            }
        }

    //filter task for day view calendar
    $scope.CalenderSearchfilter = function (record) {        
          
            //condition for title
            var istitleSearch = ($scope.Title == "" || $scope.Title == undefined) ? true : (record.TaskName.toLowerCase().indexOf($scope.Title.toLowerCase()) > -1);
            //Recurrence pattern for daily           
            return (istitleSearch);
        }
    //this is used in the week calendar view of task 
    // call while click on array sign
    $scope.clkArrowWeek = function (id) {
            var cdate = new Date($scope.currentstartofweek);
            var edate = new Date($scope.currentendofweek);
            if (id == 1) {
                $scope.currentstartofweek = cdate.setDate(cdate.getDate() - 7);
                $scope.currentendofweek = edate.setDate(edate.getDate() - 7);
                var ndate = new Date($scope.currentstartofweek);
                var ccdate = ndate.getMonth()+1 + "/" + ndate.getDate() + "/" + ndate.getFullYear();
                GetPerWeekTaskForCalendar(ccdate, $scope.currentendofweek, $scope.UserModel.UserId);
            }
            if (id == 2) {
                $scope.currentstartofweek = cdate.setDate(cdate.getDate() + 7);
                $scope.currentendofweek = edate.setDate(edate.getDate() + 7);
                var ndate = new Date($scope.currentstartofweek);
                var ccdate = ndate.getMonth()+1 + "/" + ndate.getDate() + "/" + ndate.getFullYear();
                GetPerWeekTaskForCalendar(ccdate, $scope.currentendofweek,  $scope.UserModel.UserId);
            }
        }

    //week view calendar, task filter by task name
    $scope.WeekCalendarFilterTask = function (record) {         
            
            return ($scope.Title == "" || $scope.Title == undefined) ? true : (record.TaskName.toLowerCase().indexOf($scope.Title.toLowerCase()) > -1);               
            
        }
           
    $scope.filtertaskbyId = function (record) {           
            if (record.TaskId == $scope.TaskID) return true;
            else return false;
        }

    
    //left/right functionaality for month view calendar
    $scope.clkArrowMonth = function (id) {
            var cdate = new Date($scope.currentstartofweek);
            var edate = new Date($scope.currentendofweek);
            var ccmonth = new Date($scope.MonthCalendarDate);

            if (id == 1) {
                
                ccmonth.setDate(1);
                $scope.MonthCalendarDate = ccmonth.setMonth(ccmonth.getMonth() - 1);
                $scope.CurrentMonth = $scope.Month[new Date($scope.MonthCalendarDate).getMonth()].Name + ' ' + new Date($scope.MonthCalendarDate).getFullYear();
                MonthDayPush($scope.MonthCalendarDate);
                GetPerMonthTaskForCalendar($scope.MonthCalendarDate, $scope.UserModel.UserId);
            }
            if (id == 2) {
                ccmonth.setDate(1);
                $scope.MonthCalendarDate = ccmonth.setMonth(ccmonth.getMonth() + 1);
                $scope.CurrentMonth = $scope.Month[new Date($scope.MonthCalendarDate).getMonth()].Name + ' ' + new Date($scope.MonthCalendarDate).getFullYear();
                MonthDayPush($scope.MonthCalendarDate);
                GetPerMonthTaskForCalendar($scope.MonthCalendarDate, $scope.UserModel.UserId);
            }
            else {
                MonthDayPush($scope.MonthCalendarDate);
                GetPerMonthTaskForCalendar($scope.MonthCalendarDate, $scope.UserModel.UserId);
            }
        }

    //function to push the task date into array
    function MonthDayPush(date) {
            $scope.MonthCalendarDay = [];
            var wname = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
            var currDateCalendar = new Date(date);
            $scope.NoOfDays = new Date(currDateCalendar.getFullYear(), currDateCalendar.getMonth() + 1, 0).getDate();
            currDateCalendar.setDate(1);
            var lastMonthCalendar = new Date(new Date(date).setMonth(new Date(date).getMonth() - 1));
            var weekday = currDateCalendar.getDay();
            var Countlastmonthdays = new Date(lastMonthCalendar.getFullYear(), lastMonthCalendar.getMonth() + 1, 0).getDate();
            lastMonthCalendar.setDate(Countlastmonthdays);
            var lastmonthdatedisplay = lastMonthCalendar;
            var datedisplaycurrmonth = currDateCalendar;
            if (weekday == 1) {

                $scope.MonthCalendarDay.push({
                    "Weekname": wname[new Date(lastMonthCalendar).getDay()],
                    "day": lastMonthCalendar.getDate(),
                    "isCurrentMonth": false,
                    "CDate": lastMonthCalendar
                });

            }
            else if (weekday == 2) {
                var lasDays = new Date(lastMonthCalendar);
                lastDays = new Date(lasDays.setDate(lasDays.getDate() - 2))
                for (var i = 1; i >= 0; i--) {

                    $scope.MonthCalendarDay.push({
                        "weekname": wname[new Date(lastMonthCalendar).getDay() - i],
                        "day": new Date(lastMonthCalendar).getDate() - i,
                        "isCurrentMonth": false,
                        "CDate": new Date(lasDays.setDate(lasDays.getDate() + 1))
                    });

                }

            }
            else if (weekday == 3) {

                var lasDays = new Date(lastMonthCalendar);
                lastDays = new Date(lasDays.setDate(lasDays.getDate() - 3))
                for (var i = 2; i >= 0; i--) {
                    $scope.MonthCalendarDay.push({
                        "weekname": wname[new Date(lastMonthCalendar).getDay() - i],
                        "day": new Date(lastMonthCalendar).getDate() - i,
                        "isCurrentMonth": false,
                        "CDate": new Date(lasDays.setDate(lasDays.getDate() + 1))
                    });

                }
            }
            else if (weekday == 4) {
                var lasDays = new Date(lastMonthCalendar);
                lastDays = new Date(lasDays.setDate(lasDays.getDate() - 4))
                for (var i = 3; i >= 0; i--) {

                    $scope.MonthCalendarDay.push({
                        "weekname": wname[new Date(lastMonthCalendar).getDay() - i],
                        "day": new Date(lastMonthCalendar).getDate() - i,
                        "isCurrentMonth": false,
                        "CDate": new Date(lasDays.setDate(lasDays.getDate() + 1))
                    });

                }
            }
            else if (weekday == 5) {
                var lasDays = new Date(lastMonthCalendar);
                lastDays = new Date(lasDays.setDate(lasDays.getDate() - 5))
                for (var i = 4; i >= 0; i--) {

                    $scope.MonthCalendarDay.push({
                        "weekname": wname[new Date(lastMonthCalendar).getDay() - i],
                        "day": new Date(lastMonthCalendar).getDate() - i,
                        "isCurrentMonth": false,
                        "CDate": new Date(lasDays.setDate(lasDays.getDate() + 1))
                    });

                }
            }
            else if (weekday == 6) {
                var lasDays = new Date(lastMonthCalendar);
                lastDays = new Date(lasDays.setDate(lasDays.getDate() - 6))
                for (var i = 5; i >= 0; i--) {

                    $scope.MonthCalendarDay.push({
                        "weekname": wname[new Date(lastMonthCalendar).getDay() - i],
                        "day": parseInt(new Date(lastMonthCalendar).getDate()) - i,
                        "isCurrentMonth": false,
                        "CDate": new Date(lasDays.setDate(lasDays.getDate() + 1))
                    });


                }

            }

            for (var i = 0; i < $scope.NoOfDays ; i++) {

                $scope.MonthCalendarDay.push({
                    "Weekname": wname[currDateCalendar.getDay()],
                    "day": currDateCalendar.getDate(),
                    "isCurrentMonth": true,
                    "CDate": new Date(currDateCalendar)
                });
                currDateCalendar.setDate(currDateCalendar.getDate() + 1);
            }

        }

    //to change the foreground color if there id sunday day occur
    $scope.isSundayForeColor = function (CDate) {
            var wname = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
            var Weekname = wname[CDate.getDay()];

            if (Weekname == "Sunday") {

                cc1 = { "color": "red" };
                return cc1;
            }
        }
    //check is this current month or previous month
    $scope.isCuurentMonth = function (id, day) {
            var cc = "";
            if (id == false) {
                cc = { "background-color": "lightgray" };
                return cc;
            }
            else if (id == true && day == new Date().getDate()) {
                cc = { "border": "red solid 2px" };
                return cc;
            }
        }
    //filter the task for month view calendar
    $scope.MonthCalendarFilterTask = function (currdate) {
            return function (record) {                
                return ($scope.Title == "" || $scope.Title == undefined) ? true : (record.TaskName.toLowerCase().indexOf($scope.Title.toLowerCase()) > -1);                
            }
        }
    //same functionality as fnPopId
    $scope.fnPopUser = function (id) {

            $scope.TaskID = id;
            $scope.getDetailTaskInfo(id);
        }
       
    $scope.fnPopAssign = function (id) {           
        $scope.TaskID = id;
        $scope.getDetailTaskInfo(id);
           
            
        }

    $scope.AddUser = function() {         
           
            var TaskId = $scope.TaskID;
            var UserId = $scope.userid;
            var displayname = "";
            for (var i = 0; i < $scope.UsersList.length; i++)
            {
                if ($scope.UsersList[i].UserId == UserId) {
                    displayname = $scope.UsersList[i].DisplayName;
                    break;
                }
               
            }
            
            AssignUserList(UserId, displayname);
        }

    function AssignUserList(userId, name) {
            var isEsist = true;
            for(var j= 0; j<$scope.PushAssignUser.length; j++)
                {
                if ($scope.PushAssignUser[j].UserId == userId)
                {
                    isEsist = false;
                    break;
                }
            }
            if (isEsist) {
                $scope.PushAssignUser.push({
                    "UserId": userId,
                    "DisplayName": name
                });
            }
        }
    //task/sub task  assignment
    //Assign to any active directory user
    $scope.SaveAssignment = function () {
            var item = {
                TaskId: $scope.TaskID,
                UserId: $scope.userid

            };
            var promisePost = ERCTask_Service.AssignedToUser($scope.PushAssignUser, $scope.TaskID);
            promisePost.then(function (pl) {
                item = {};
                $scope.getDetailTaskInfo($scope.TaskID);
                GetPerMonthTaskForCalendar($scope.MonthCalendarDate, $scope.UserModel.UserId);
                GetPerWeekTaskForCalendar($scope.currentstartofweek, new Date(), $scope.UserModel.UserId);
                GetAllTaskRecords();
                $scope.userid = "";
            }, function (err) {

            });
        }
    //function to get the task detail
    //get task detail and assign to model
      
    $scope.GetTaskDetail = function (id) {
            var tt = $scope.ERC.Tasks;
            $scope.TaskID = id;
            for (var i = 0; i < tt.length; i++) {
                if (id == tt[i].TaskId) {
                    var idx = tt[i].RecurrenceBusinessDayStep;
                    if (idx <= 6) idx--;
                    else idx = idx + 12;
                    if (tt[i].RecurrencePattern == "Daily") idx = "0";
                    $scope.TaskModal.RecurrencePattern1 = tt[i].RecurrencePattern;
                    $scope.TaskModal.RecurrenceBusinessDayStep1 = idx;
                    $scope.TaskModal.ercTaskTitle1 = tt[i].TaskName;
                    $scope.TaskModal.ercTaskDesc1 = tt[i].TaskDesc;
                    $scope.TaskModal.ercSubTaskDuedate1 = tt[i].TaskDueDate;
                    $scope.TaskModal.TaskDueHour1 = String(tt[i].TaskDueHour);
                    $scope.TaskModal.TaskDueMinutes1 = String(tt[i].TaskDueMinutes);
                    $scope.TaskModal.customerEdit = tt[i].Customer;
                    
                }
            }
            
    }

    //function to get the Meeting History
    //get Meeting History and assign to model

    //$scope.GetMeetingHistory = function (id) {
    //    var tt = $scope.MeetingHistory.Description;
    //    $scope.TaskID = id;
    //    for (var i = 0; i < tt.length; i++) {
    //        if (id == tt[i].TaskId) {
    //            var idx = tt[i].RecurrenceBusinessDayStep;
    //            if (idx <= 6) idx--;
    //            else idx = idx + 12;
    //            if (tt[i].RecurrencePattern == "Daily") idx = "0";
    //            $scope.TaskModal.RecurrencePattern1 = tt[i].RecurrencePattern;
    //            $scope.TaskModal.RecurrenceBusinessDayStep1 = idx;
    //            $scope.TaskModal.ercTaskTitle1 = tt[i].TaskName;
    //            $scope.TaskModal.ercTaskDesc1 = tt[i].TaskDesc;
    //            $scope.TaskModal.ercSubTaskDuedate1 = tt[i].TaskDueDate;
    //            $scope.TaskModal.TaskDueHour1 = String(tt[i].TaskDueHour);
    //            $scope.TaskModal.TaskDueMinutes1 = String(tt[i].TaskDueMinutes);
    //            $scope.TaskModal.customerEdit = tt[i].Customer;

    //        }
    //    }

   // }

    //function to filter the task according to the recurrence setting
    //Recurrence setting may be daily, Monthly or yearly
    //if there is no recurrence of task then task will display only on due date
    $scope.FilterCriteriaCardView = function (record) {
            var TaskName = $scope.Title;
            var isTaskNameProvided = (TaskName == "" || TaskName == undefined) ? true : (record.TaskName.toLowerCase().indexOf(TaskName.toLowerCase()) > -1);
            return isTaskNameProvided && (record.isComplete == 0)?true:false;
        }
    //function to edit the task or sub task
    $scope.EditItem = function () {
            var idx = $scope.TaskModal.RecurrenceBusinessDayStep1;
            if (idx < 6) idx++;
            else idx = idx - 12;
            var item1 = {
                TaskId: $scope.TaskID,
                TaskName: $scope.TaskModal.ercTaskTitle1,
                TaskDesc: $scope.TaskModal.ercTaskDesc1,
                TaskDueDate: $scope.TaskModal.ercSubTaskDuedate1,
                AdminId: $scope.UserModel.UserId,
                RecurrenceBusinessDayStep: idx,
                RecurrencePattern: $scope.TaskModal.RecurrencePattern1,
                Customer:$scope.TaskModal.customerEdit

            };

            var promisePost = ERCTask_Service.EditTask(item1);
            promisePost.then(function (pl) {
                GetAllTaskRecords();

            }, function (err) {

            });
        }

    //this function is require wherever the week day name and week number is need to display and check
    function weekAndDay(dd) {
            var date = new Date(dd),
                days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'],
                prefixes = ['First', 'Second', 'Third', 'Fourth', 'Fifth', 'Sixth'];
            return prefixes[0 | date.getDate() / 7] + ' ' + days[date.getDay()];
        }
    //to get the recurrence pattern steps
    $scope.GetRecurrencePatternSteps = function(pattern, steps)
        {
            if (pattern == "Daily") return ' ';
            else if (pattern == "Weekly" && steps == 1) return "Every first";
            else if (pattern == "Weekly" && steps == 2) return "Every second";
            else if (pattern == "Weekly" && steps == 3) return "Every third";
            else if (pattern == "Weekly" && steps == 4) return "Every fourth";
            else if (pattern == "Weekly" && steps == 5) return "Every fifth";
            else if (pattern == "Weekly" && steps == 6) return "Every sixth";
            else if (pattern == "Weekly" && steps == -6) return "Sixth from EOW";
            else if (pattern == "Weekly" && steps == -5) return "Fifth from EOW";
            else if (pattern == "Weekly" && steps == -4) return "Fourth from EOW";
            else if (pattern == "Weekly" && steps == -3) return "Third from EOW";
            else if (pattern == "Weekly" && steps == -2) return "Second from EOW";
            else if (pattern == "Weekly" && steps == -1) return "First from EOW";

            else if (pattern == "Monthly" && steps == 1) return "Every first";
            else if (pattern == "Monthly" && steps == 2) return "Every second";
            else if (pattern == "Monthly" && steps == 3) return "Every third";
            else if (pattern == "Monthly" && steps == 4) return "Every fourth";
            else if (pattern == "Monthly" && steps == 5) return "Every fifth";
            else if (pattern == "Monthly" && steps == 6) return "Every sixth";
            else if (pattern == "Monthly" && steps == -6) return "Sixth from EOM";
            else if (pattern == "Monthly" && steps == -5) return "Fifth from EOM";
            else if (pattern == "Monthly" && steps == -4) return "Fourth from EOM";
            else if (pattern == "Monthly" && steps == -3) return "Third from EOM";
            else if (pattern == "Monthly" && steps == -2) return "Second from EOM";
            else if (pattern == "Monthly" && steps == -1) return "Sixth from EOM";
        }
    $scope.RecurrencePatternText = function (pattern, steps, hour, minutes, due) {
        if (pattern != null || pattern != '') {
            var patternstring = $scope.GetRecurrencePatternSteps(pattern, steps);
            var phour = hour + minutes == 0 ? 0 : parseFloat(minutes / 60);
            var pmam = phour >= phour ? "PM" : "AM";
           // var format12hrtime = (hour < 10 ? "0" + (hour > 12 ? hour - 12 : hour) : (hour > 12 ? hour - 12 : hour)) + ':' + (minutes < 10 ? "0" + minutes : minutes) + ' ' + pmam;
            return "Task set to recur every " + (patternstring.indexOf("Every") > -1 ? patternstring.replace("Every", '') : patternstring) + " business day " + ((pattern == "Daily") ? "" : pattern);// + " at " + format12hrtime;

        } else {
            return "Task set to take place " + due;
        }
        }
    //Get per day task for task view
    function GetPerTaskforCalendarView(currentDate, UserId) {
        $scope.ERC_Load.loading = true;
            var cdate = currentDate.getMonth() + 1 + "-" + currentDate.getDate() + "-" + currentDate.getFullYear();           
        ERCTask_Service.GetPerDayTaskForCalendar(cdate, UserId).success(function (data, status) {

                if (data != null) {
                    $scope.ERC_Day.PerDayTask = data;
                   // console.log(data);
                   $scope.ERC_Load.loading = false;
                }
            }).error(function (data, status) {

            });
        }
    //to get the weekly task for calendar
    function GetPerWeekTaskForCalendar(sdate, edate, UserId) {

        $scope.ERC_Load.loading = true;
            sdate = new Date(sdate);
            edate = new Date(edate);
            var s_date = sdate.getMonth() + 1 + "-" + sdate.getDate() + "-" + sdate.getFullYear();
            var e_date = edate.getMonth() + 1 + "-" + edate.getDate() + "-" + edate.getFullYear();
            ERCTask_Service.GetPerWeekTaskForCalendar(s_date, e_date, UserId).success(function (data, status) {
                if (data != null) {
                    $scope.PerWeekTask = data;
                    $scope.ERC_Load.loading = false;
                   // console.log(data);

                }
            }).error(function (data, status) {

            });
        }
    //to get the monthly task for calendar
    function GetPerMonthTaskForCalendar(sdate, userId) {
        $scope.ERC_Load.loading = true;
        sdate = new Date($scope.CurrentMonth);
            var s_date = sdate.getMonth() + 1 + "-" + sdate.getDate() + "-" + sdate.getFullYear();
            if ($scope.UserModel.UserId != null) {
                ERCTask_Service.GetPerMonthTaskForCalendar(s_date, userId ).success(function (data, status) {
                    if (data != null) {
                        
                        $scope.PeMonthTask = data;
                        $scope.ERC_Load.loading = false;
                       // console.log(data);

                    }
                }).error(function (data, status) {

                });
            }
        }
    function RecurrencePatternTextMessage(pattern, steps, due) {
            if (pattern != null || pattern != '') {
                var patternstring = $scope.GetRecurrencePatternSteps(pattern, steps);               
               // var phour = hour + minutes==0?0:parseFloat(minutes / 60);
               // var pmam = phour >= phour ? "PM" : "AM";
               // var format12hrtime = (hour < 10 ? "0" + (hour > 12 ? hour - 12 : hour) : (hour > 12 ? hour - 12 : hour)) + ':' + (minutes < 10 ? "0" + minutes : minutes) + ' ' + pmam;
                return "Task set to recur every " + (patternstring.indexOf("Every") > -1 ? patternstring.replace("Every", '') : patternstring) + " business day " + ((pattern == "Daily") ? "" : pattern);// + " at " + format12hrtime;

            } else {
                return "Task set to take place " + due;
            }
        }
    //function for task detail
    $scope.fnCalendatTaskDetail = function (taskid, type) {
        $scope.TaskID = taskid;

        $scope.getDetailTaskInfo(taskid);

            $scope.TaskDetailType = type;
            var isComplete = false;//if meet the taskId then need to break the first for loop
            if(type == 3)
            {
                var monthtask = $scope.PeMonthTask;                
                for (var i = 0; i < monthtask.length; i++) {    //loop for whole month length
                    var eachdayTask = monthtask[i];
                   // alert(JSON.stringify(eachdayTask));
                    if (monthtask[i].length > 0) {
                        for (j = 0; j < eachdayTask.length; j++) {
                            if (eachdayTask[j].TaskId == taskid) {
                                isComplete = true;
                                $scope.ERCCalendar.CalendarTaskDetailTaskname = eachdayTask[j].TaskName;
                                $scope.ERCCalendar.CalendarTaskDetailTaskDesc = eachdayTask[j].TaskDesc;
                                $scope.ERCCalendar.CalendarTaskDetailDescription = eachdayTask[j].Description;
                                $scope.ERCCalendar.CreatedDate = eachdayTask[j].CreatedDate;
                               // alert(JSON.stringify(eachdayTask[j].Description.length));
                                //$scope.ERCCalendar.CalendarTaskDetailTaskDueHour = eachdayTask[j].TaskDueHour;
                                //$scope.ERCCalendar.CalendarTaskDetailTaskDueMinutes = eachdayTask[j].TaskDueMinutes;
                                $scope.ERCCalendar.Customer = eachdayTask[j].Customer;
                                $scope.ERCCalendar.CalendarTaskDetailRecurrencePatternMsg = RecurrencePatternTextMessage(eachdayTask[j].RecurrencePattern, eachdayTask[j].RecurrenceBusinessDayStep, eachdayTask[j].TaskDueDate);
                                                       
                               
                                 break;
                            }
                        }
                    }
                    if (isComplete) break;
                }
            }

            if (type == 2) {
                isComplete = false;               
                var Weektask = $scope.PerWeekTask;
                for (var i = 0; i < Weektask.length; i++) {//loop for whole week task                   
                    var eachdayTask = Weektask[i];
                    if (Weektask[i].length > 0) {
                        for (j = 0; j < eachdayTask.length; j++) {                           
                            if (eachdayTask[j].TaskId == taskid) {                                
                                isComplete = true;
                                $scope.ERCCalendar.CalendarTaskDetailTaskname = eachdayTask[j].TaskName;
                                $scope.ERCCalendar.CalendarTaskDetailTaskDesc = eachdayTask[j].TaskDesc;
                                $scope.ERCCalendar.CalendarTaskDetailDescription = eachdayTask[j].Description;
                                $scope.ERCCalendar.CreatedDate = eachdayTask[j].CreatedDate;
                                //alert(JSON.stringify($scope.ERCCalendar.CalendarTaskDetailDescription));
                                //$scope.ERCCalendar.CalendarTaskDetailTaskDueHour = eachdayTask[j].TaskDueHour;
                                //$scope.ERCCalendar.CalendarTaskDetailTaskDueMinutes = eachdayTask[j].TaskDueMinutes;
                                $scope.ERCCalendar.Customer = eachdayTask[j].Customer;
                                $scope.ERCCalendar.CalendarTaskDetailRecurrencePatternMsg = RecurrencePatternTextMessage(eachdayTask[j].RecurrencePattern, eachdayTask[j].RecurrenceBusinessDayStep, eachdayTask[j].TaskDueDate);
                                                                                     
                                break;
                            }
                        }
                    }
                    if (isComplete) break;
                }
            }
        }
    //Insert tag functionality
    $scope.SaveTag = function () {
            var id = $scope.TaskID;
            var item = {
                tag: $scope.tagText

            };
            var promisePost = ERCTask_Service.SaveTags(item, id);
            promisePost.then(function (pl) {
                item = {};
                $scope.getDetailTaskInfo($scope.TaskID);
                $scope.tagText = "";
            }, function (err) {

            });
        }
    // Count Tag by Id
    $scope.TagsDetail = function (id) {
        
        var tt = $scope.TaskInfo.tags;
      
            //$scope.PushTags = [];
            for (var i = 0; i < tt.length; i++) {
                if (id == tt[i].TaskId) {                  
                        if (tt[i].TagId != $scope.TagId) {
                            $scope.PushTags.push({
                                "TagId": tt[i].TagId,
                                "tag": tt[i].tag,
                                "TaskId": id
                            });
                        }
                    
                }
            }          
        }
    //this function is call when any modal popup require 
    //assign Tag Id  to global scope
    $scope.fnPopTagId = function (id, taskId) {
        $scope.TagId = id;      
        $scope.getDetailTaskInfo(taskId);

        }
    //Remove Tag
    $scope.removeTag = function () {       
            var promiseDelete = ERCTask_Service.DeleteTag($scope.TagId);
            promiseDelete.then(function (pl) {                
               // GetAllTaskRecords();                
                for (var i = 0; i < $scope.PushTags.length; i++) {
                    if ($scope.PushTags[i].TagId == $scope.TagId) $scope.PushTags.splice(i, 1);
                } 
            }, function (err) {
                // console.log("Some Error Occured." + err);
            });

        }
    //assign values for delete assignment
    $scope.PopAssignment = function (UserId, TaskId) {            
            $scope.TaskID = TaskId;
            $scope.RemoveUserId = UserId;
        }
    //remove assigned user
    $scope.removeAssignment = function () {           
            ERCTask_Service.RemoveAssignment($scope.RemoveUserId, $scope.TaskID).success(function (data, status) {
                if (data != null) {
                   
                    for (var i = 0; i < $scope.PushAssignUser.length; i++)
                    {
                        if ($scope.PushAssignUser[i].UserId == $scope.RemoveUserId) $scope.PushAssignUser.splice(i, 1);
                    }

                    GetPerMonthTaskForCalendar($scope.MonthCalendarDate, $scope.UserModel.UserId);                    
                    GetPerWeekTaskForCalendar($scope.currentstartofweek, new Date(), $scope.UserModel.UserId);
                   
                    GetAllTaskRecords();
                }
            }).error(function (data, status) {

            });
        }
    //function to logout
    $scope.logoutUser = function () {

            var promiseget = ERCTask_Service.Logout();
            promiseget.then(function (pl) {
            }, function (err) {
                // console.log("Some Error Occured." + err);
            });
            $scope.UserModel = null;
            $scope.userid = null;
            $scope.password = null;
            $scope.ERC.Tasks = null;

    }
    //function to mark a task as complete. 

    $scope.MarkTaskComplete = function (id) {
        var userId = $scope.UserModel.UserId;
        var TaskId = id;
        if ($scope.MarkComplete.mark != 0) {           
            var promisePost = ERCTask_Service.MarkTaskComplete(TaskId, userId);
            promisePost.then(function (pl) {
                GetAllTaskRecords();
                console.log(pl.data);
            }, function (err) {
                console.log("Some Error Occured." + err);
            });
        }
    }
    //get task information on user demand
    $scope.getDetailTaskInfo = function (id) {
        var promiseget = ERCTask_Service.getUserTaskInfo(id);
        promiseget.then(function (pl) {
            if (pl.data != null)
            {
                $scope.TaskInfo = pl.data;
                $scope.PushAssignUser = [];
                var tsk = $scope.TaskInfo.AssignedTo;
                for (var i = 0; i < tsk.length; i++) {

                    AssignUserList(tsk[i].UserId, tsk[i].DisplayName);

                }

                $scope.PushTags = [];
                tt = $scope.TaskInfo.tags;
                for (var i = 0; i < tt.length; i++) {                   
                            $scope.PushTags.push({
                                "TagId": tt[i].TagId,
                                "tag": tt[i].tag,
                                "TaskId": id
                            });                        
                }
            }

            else console.log("Users not available in database.");
        },
               function (errorpl) {
                   console.log("Error to fetch users.");
               });

    }
    //Function to save all checked userid
    $scope.SaveAdminUsers = function () {
        var userId = $scope.UserModel.UserId;
        var CheckedUser = String($scope.selection);
        if (CheckedUser == "") {
            CheckedUser = "NULL";
        }
        var promisePost = ERCTask_Service.SaveAdminUsers(CheckedUser, userId);
        promisePost.then(function (pl) {
            GetAllTaskRecords();
           GetAdminUsers();
            console.log(pl.data);
        }, function (err) {
            console.log("Some Error Occured." + err);
        });
    }
    //Function to get all checked UserdId 
    function GetAdminUsers() {
        $scope.AdminUser = [];
        var UserId = $scope.UserModel.UserId;
        promiseGet = ERCTask_Service.GetAdminUsers(UserId);
        promiseGet.then(function (pl) {
            $scope.AdminUserList = pl.data;
            $scope.countUsers.count = $scope.AdminUserList.length;
            for (var i = 0; i < $scope.AdminUserList.length ; i++) {
                $scope.AdminUser.push($scope.AdminUserList[i].UserId);
            }
            
           $scope.selection = $scope.AdminUser;
                    }, function (err) {
            console.log("Some Error Occured." + err);
        });
        

    }
   // this function restrict to enter white space in textbox
    $scope.RestrictWhiteSpace = function () {
        $scope.userAvailabe = "";
        if ($scope.Register.UserName != undefined) {
           $scope.Register.UserName = $scope.Register.UserName.split(' ').join('');
            var users = $scope.UsersList;
            var uservalue=$scope.Register.UserName;
            for (var i = 0; i < users.length; i++) {
                if (users[i].UserName.toLowerCase() == uservalue.toLowerCase()) {
                    $scope.userAvailabe = "User Exist !!!";
                    break;
                  }
                else {
                    $scope.userAvailabe = null;
                }
            }
        }
    }
    //this function change the color of follow off task description
    $scope.isFirstIndexChangeColor = function (isFirst) {
        if (isFirst == true) {
            var cc = "";

            cc = { "background-color": "#DAD6D6;", "color": "red", "font-weight": "bold" };
            return cc;

        }
    }
        $scope.isFirstHeaderIndexChangeColor = function (isFirst) {
            if (isFirst == true) {
                var cc = "";
           
                cc = { "background-color": "rgb(197, 199, 199);", "color": "blue", "font-weight": "bold" };
                return cc;
          
            }
    }
  
    // this function check the today task and return value for color
        $scope.isCurrentDateChangeColor = function (CDate) {
            //alert(CDate);
            var tdate = new Date(CDate);
            var ttdate = tdate.getMonth() + 1 + "-" + tdate.getDate() + "-" + tdate.getFullYear();
            var syscurrentdate = new Date();
            var syscurrentdate1 = syscurrentdate.getMonth() + 1 + "-" + syscurrentdate.getDate() + "-" + syscurrentdate.getFullYear();
           // alert(ttdate);
            if (ttdate == syscurrentdate1) {
                var cc2 = "";

               // alert(CDate);
                cc2 = { "color": "Red" };
                return cc2;

            }
        }
        
   
});





