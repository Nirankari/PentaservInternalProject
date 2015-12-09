///reference path modules.js

app.service("ERCTask_Service", function ($http) {
    // Do not hardcode hosts. 
    // var url = "/api/";
    this.getUserTasks = function (userId) {        
        return $http.get("/api/Tasks/GetUserTasks/"+userId);
    };

    //this.getMeetingHistory = function (adminId) {
    //    return $http.get("/api/Tasks/GetMeetingHistory/" + adminId);
    //};

    this.getUserTaskInfo = function (TaskId) {
        return $http.get("/api/Tasks/GetUserTaskInfo/" + TaskId);
    };
    
    this.Login = function (userName, password) {
       
        return $http({
            url: "/api/Auth/Login",
            method: "post",
            data: { UserName: userName, Password: password }
        });
    }

    this.IsLoggedIn = function () {
        return $http({
            url: "/api/Auth/IsLoggedIn",
            method: "GET",
        });
    }
    
    //create new task 
    this.AddTask = function (item) {

        var request = $http({
            method: "post",
            url: "/api/Tasks/AddTask",
            data: item
        }
            );
        return request;
    };
    this.AssignedToUser = function (item,id) {

        var request = $http({
            method: "post",
            url: "/api/Tasks/AssignedToUser/" + id,
            data: item
        }
            );
        return request;
    };

    //delete task 
    this.DeleteTask = function (id) {
        var request = $http({
            method: "delete",
            url: "/api/Tasks/DeleteTasks/" + id
        }
            );
        return request;
    }
    this.GetUsers = function (Uid) {
        return $http.get("/api/tasks/GetUsers/"+Uid);
    };
    // Edit task
    this.EditTask = function (item) {
        var request = $http({
            method: "post",
            url: "/api/Tasks/EditTask",
            data: item
        }
            );
        return request;
    }
    //get per day task
    this.GetPerDayTaskForCalendar = function (cdate, UserId) {
        return $http.get("/api/Tasks/GetPerDayTaskForCalendar/" + cdate + "/" + UserId);
    }
    //get per week task
    this.GetPerWeekTaskForCalendar = function (sdate, edate, UserId) {
        return $http.get("/api/Tasks/GetWeeklyTaskForCalendar/" + sdate + "/" + edate + "/" + UserId);
    }

    //get per week task
    this.GetPerMonthTaskForCalendar = function (sdate, userId) {
        
        return $http.get("/api/Tasks/GetPerMonthTaskForCalendar/" + sdate + "/" + userId);
    }

    ///reference path modules.js

    //Save Tags
    this.SaveTags = function (item, id) {
        var request = $http({
            method: "post",
            url: "/api/Tasks/SaveTags/" + id,
            data: item
        }
           );
        return request;
    }
    //delete tag 
    this.DeleteTag = function (id) {
        var request = $http({
            method: "delete",
            url: "/api/Tasks/DeleteTag/" + id
        }
          );
        return request;
    }

    //remove assigned user
    this.RemoveAssignment = function (UserId, TaskId)
    {
        var request = $http({
            method: "delete",
            url: "/api/Tasks/RemoveAssignedUser/" + UserId + "/" + TaskId
        }
         );
        return request;
    }
    // funtion for logout /clear session
    this.Logout = function () {
        return $http.get("/api/Auth/Logout");
    }
    //function for Mark Task Complete
    this.MarkTaskComplete = function (TaskId, userId) {
         var request = $http({
             method: "post",
            url: "/api/Tasks/MarkTaskComplete/" + TaskId + "/" + userId
         });
         return request;
    }
    //add admin user and its related users
    this.SaveAdminUsers = function (CheckedUser, userId) {
            var request = $http({
            method: "post",
            url: "/api/Tasks/SaveAdminUsers/" + CheckedUser + "/" + userId,
            data:CheckedUser
        }
         );
        return request;
    }
    //function for get checked admin/user UserId 
    this.GetAdminUsers = function (UserId) {

        return $http.get("/api/Tasks/GetAdminUsers/" + UserId);
    }
    //create new  user
    this.CreateUser = function (item) {
        var request = $http({
            method: "post",
            url: "/api/Auth/CreateUser",
            data: item
        }
          );
        return request;
    };
   
   
});