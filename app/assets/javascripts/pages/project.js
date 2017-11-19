(function ($, window) {
  window.AnotherVu = window.AnotherVu || {}

  AnotherVu.Project = {
    init: function () {
      // Set up cloudinary responsive images
      $.cloudinary.responsive();
      AnotherVu.Project.handleHeartClick();
    },
    handleHeartClick: function () {
      $(".project-heart").on("click", function () {
        var projectId = $("#showProject").data("project-id");
        var $heartEl = $(this);

        if ($(this).hasClass("favorited")) {
          // It's favorited so unfavorite it
          $heartEl.removeClass("favorited");
          $heartEl.children("i").removeClass("fa-heart").addClass("fa-heart-o");
          $heartEl.hide();

          var heartId = $(this).data("heartId");
          AnotherVu.Project.removeHeart(heartId, $heartEl);
        } else {
          // Favorite the project for the user
          $heartEl.addClass("favorited");
          $heartEl.children("i").removeClass("fa-heart-o").addClass("fa-heart");
          $heartEl.hide();

          AnotherVu.Project.addHeart(projectId, $heartEl);
        }
      });
    },
    removeHeart: function (heartId, $heartEl) {
      var url = $("#showProject").data("hearts-url") + "/" + heartId;

      $.ajax({
        url: url,
        headers: {
          id: heartId
        },
        type: "DELETE",
        success: function (response) {
          $heartEl.show();
        },
        error: function (response) {
          console.error(response);
        }
      });
    },
    addHeart: function (projectId, $heartEl) {
      var url = $("#showProject").data("hearts-url");

      $.ajax({
        url: url,
        data: {
          heart: {
            project_id: projectId
          }
        },
        type: "POST",
        success: function (response) {
          $heartEl.data("heart-id", response.id);
          $heartEl.show();
        },
        error: function (response) {
          console.error(response);
        }
      });
    }
  }

  window.AnotherVu = AnotherVu;

  $(document).on('turbolinks:load', AnotherVu.Project.init);

})(jQuery, this);
