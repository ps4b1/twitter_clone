$(".comment").each(function () {
    $(this).on("click",function(){
        $(this).closest('div').find('.comment_area').toggle();
    })
})
