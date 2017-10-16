(function ($, window) {
  window.AnotherVu = window.AnotherVu || {}

  AnotherVu.Feed = {
    init: function () {
      AnotherVu.Feed.handleHeartClick();
    },
    handleHeartClick: function () {
      $(".heart").on("click", function () {
        var uploadId = $(this).parent(".upload").data("id");
        var $heartEl = $(this);

        if ($(this).hasClass("favorited")) {
          // It's favorited so unfavorite it
          $heartEl.removeClass("favorited");
          $heartEl.children("i").removeClass("fa-heart").addClass("fa-heart-o");
          $heartEl.hide();

          var heartId = $(this).data("heartId");
          AnotherVu.Feed.removeHeart(heartId, $heartEl);
        } else {
          // Favorite the upload for the user
          $heartEl.addClass("favorited");
          $heartEl.children("i").removeClass("fa-heart-o").addClass("fa-heart");
          $heartEl.hide();

          AnotherVu.Feed.addHeart(uploadId, $heartEl);
        }
      });
    },
    removeHeart: function (heartId, $heartEl) {
      var url = $("#feed").data("hearts-url") + "/" + heartId;

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
    addHeart: function (uploadId, $heartEl) {
      var url = $("#feed").data("hearts-url");

      $.ajax({
        url: url,
        data: {
          heart: {
            upload_id: uploadId
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

  $(document).ready(AnotherVu.Feed.init);

})(jQuery, this);
