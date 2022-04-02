$(".reply").each(function () {
    $(this).on("click",function(){
        $(this).closest('div').find('.reply_area').toggle();
    })
})