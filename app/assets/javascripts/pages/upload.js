(function ($, window) {
  window.AnotherVu = window.AnotherVu || {}

  AnotherVu.Upload = {
    init: function () {
      AnotherVu.Upload.setupCloudinaryUpload();
    },
    setupCloudinaryUpload: function () {
      $(".cloudinary-fileupload").cloudinary_fileupload({
        // Uncomment the following lines to enable client side image resizing and valiation.
        // Make sure cloudinary/processing is included the js file
        //disableImageResize: false,
        //imageMaxWidth: 800,
        //imageMaxHeight: 600,
        //acceptFileTypes: /(\.|\/)(gif|jpe?g|png|bmp|ico)$/i,
        //maxFileSize: 20000000, // 20MB
        dropZone: "#dropZone",
        start: function (e) {
          $(".status").text("Starting upload...");
        },
        progress: function (e, data) {
          $(".status").text("Uploading... " + Math.round((data.loaded * 100.0) / data.total) + "%");
        },
        fail: function (e, data) {
          $(".status").text("Upload failed");
        }
      }).off("cloudinarydone").on("cloudinarydone", function (e, data) {
        $(".status").text("");
        var preview = $(".preview").html('');
        $.cloudinary.image(data.result.public_id, {
          format: data.result.format,
          height: 200,
          width: "auto",
          crop: "scale"
        }).appendTo(preview);

        $('<a><i class="fa fa-trash-o"></i><a/>').
          addClass('delete_by_token').
          attr({ href: '#' }).
          data({ delete_token: data.result.delete_token }).
          appendTo(preview).
          click(function (e) {
            e.preventDefault();
            $.cloudinary.delete_by_token($(this).data('delete_token')).done(function () {
              $('.preview').html('');
              // $('#info').html('');
              $('input[name="photo[image]"]').remove();
            }).fail(function () {
              $('.status').text("Cannot delete image");
            });
          });

        // var upload = data.result;

        // // Build an html table out of the upload object
        // var rows = [];
        // $.each(upload, function (k, v) {
        //   rows.push(
        //     $("<tr>")
        //       .append($("<td>").text(k))
        //       .append($("<td>").text(JSON.stringify(v))));
        // });
        // $("#info").html(
        //   $("<div class=\"upload_details\">")
        //     .append("<h2>Upload metadata:</h2>")
        //     .append($("<table>").append(rows)
        //     )
        // );
      });
    }
  }

  window.AnotherVu = AnotherVu;

  $(document).on('turbolinks:load', AnotherVu.Upload.init);

})(jQuery, this);
