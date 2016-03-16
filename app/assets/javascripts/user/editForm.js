$(document).ready(function() {
    $('#editForm').validate({
        errorClass: "error-view",
        validClass: "success-view",
        errorElement: "span",
        onkeyup: !1,
        onclick: !1,
        rules: {
            first_name: {
                required: !0
            },
            last_name: {
                required: !0
            },
            email: {
                required: !0,
                email: !0
            },
            gender: {
                required: !0
            },
            dob: {
                required: !0
            },
            town: {
                required: !0
            },
            phone: {
                required: !0
            },
            country: {
                required: !0
            },
            city: {
                required: !0
            },
            prof: {
                required: !0
            },
            company: {
                required: !0
            },
            skills: {
                required: !0
            },
            exp: {
                required: !0
            },
            grad: {
                required: !0
            },
            univ: {
                required: !0
            },
            web: {
                required: !0
            },
            post: {
                required: !0
            },
            address: {
                required: !0
            },
            message: {
                required: !0
            },
            quote: {
                required: !0
            },
            position: {
                required: !0
            },
            file1: {
                required: !0,
                extension: "doc|docx|xls|xlsx"
            },
            file2: {
                required: !0,
                extension: "doc|docx|xls|xlsx"
            }

        },
        messages: {
            first_name: {
                required: "Please enter your first name"
            },
            last_name: {
                required: "Please enter your last name"
            },
            email: {
                required: "Please enter your email",
                email: "Incorrect email format"
            }

            ,
            phone: {
                required: "Please enter your phone"
            },
            country: {
                required: "Please select a country"
            },
            gender: {
                required: "Please Select a gender"
            },
            dob: {
                required: "Please Select your Date Of Birth"
            },
            town: {
                required: "Please Enter your town"
            },
            city: {
                required: "Please enter a city"
            },
            prof: {
                required: "Please enter a Profession"
            },
            company: {
                required: "Please enter a Company"
            },
            skills: {
                required: "Please enter a skills"
            },
            exp: {
                required: "Please Select a Experience"
            },
            grad: {
                required: "Please Select a graduation"
            },
            univ: {
                required: "Please enter a univercity"
            },
            web: {
                required: "Please enter a website"
            },
            post: {
                required: "Please enter a post code"
            },
            address: {
                required: "Please enter your address"
            },
            message: {
                required: "Please enter About yourself"
            },
            quote: {
                required: "Please enter quote"
            },
            position: {
                required: "Please select desired position"
            },
            file1: {
                required: "Please upload some file",
                extension: "Incorrect file format"
            },
            file2: {
                required: "Please upload some file",
                extension: "Incorrect file format"
            }

        },
        highlight: function(e, s, t) {
            $(e).closest(".input").removeClass(t).addClass(s), ($(e).is(":checkbox") || $(e).is(":radio")) && $(e).closest(".check").removeClass(t).addClass(s)
        },
        gender: {
            required: "Please select gender"
        },
        unhighlight: function(e, s, t) {
            $(e).closest(".input").removeClass(s).addClass(t), ($(e).is(":checkbox") || $(e).is(":radio")) && $(e).closest(".check").removeClass(s).addClass(t)
        },
        errorPlacement: function(e, s) {
            $(s).is(":checkbox") || $(s).is(":radio") ? $(s).closest(".check").append(e) : $(s).closest(".unit").append(e)
        }
    });
});
