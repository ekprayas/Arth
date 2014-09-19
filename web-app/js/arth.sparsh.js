$(document)
		.ready(
				function() {
					if ($('.pagination').children('.prevLink').size() > 0) {
						$('<li>').appendTo($('.pagination')).append(
								$('.pagination').children('.prevLink')[0])
								.addClass('arrow');
					} else {
						$('<li>').appendTo($('.pagination')).append(
								'<a href="">Previous</a>').addClass(
								'arrow unavailable');
					}
					var tmpSize = $('.pagination').children('.step').size();
					for ( var i = 0; i < tmpSize; i++) {
						if ($('.pagination').children()[0].className == 'currentStep') {
							$('<li>')
									.appendTo($('.pagination'))
									.append(
											'<a href="">'
													+ $('.pagination')
															.children()[0].innerText
													+ '</a>').addClass(
											'current');
							$('.pagination').children()[0].remove();
						}

						$('<li>').appendTo($('.pagination')).append(
								$('.pagination').children('.step')[0]);

						if ($('.pagination').children()[0].className == 'currentStep') {
							$('<li>')
									.appendTo($('.pagination'))
									.append(
											'<a href="">'
													+ $('.pagination')
															.children()[0].innerText
													+ '</a>').addClass(
											'current');
							$('.pagination').children()[0].remove();
						}
					}
					if ($('.pagination').children('.nextLink').size() > 0) {
						$('<li>').appendTo($('.pagination')).append(
								$('.pagination').children('.nextLink')[0])
								.addClass('arrow');
					} else {
						$('<li>').appendTo($('.pagination')).append(
								'<a href="">Next</a>').addClass(
								'arrow unavailable');
					}
					$('.inline-list')
							.first()
							.append(
									'<li><span class="radius secondary label"><a onclick="window.history.back()">Back</a></span></li>')
							.addClass('right').children().removeClass('right');
				});