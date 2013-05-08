//
//  InfoFillInViewController.m
//  Together
//
//  Created by Gnef_jp on 13-4-26.
//  Copyright (c) 2013年 GMET. All rights reserved.
//
#import "TipViewManager.h"

#import "InfoFillInViewController.h"

#define kTextMaxLength      30
#define kPanWidth           10

@implementation InfoFillInViewController
@synthesize delegate = _delegate;

- (void) dealloc
{
    [[TipViewManager defaultManager] removeTipWithID:self];
}

- (void)viewDidUnload
{
    [self setTitleLabel:nil];
    _textField = nil;
    _textView = nil;
    _tableView = nil;
    _confirmBtn = nil;
    
    [[TipViewManager defaultManager] removeTipWithID:self];
    _inputBgImageView = nil;
    
    _inputLengthView = nil;
    _inputLengthLabel = nil;
    [super viewDidUnload];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _textField.delegate = self;
    _textView.delegate = self;
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _textMaxLength = kTextMaxLength;
    
    _inputBgImageView.image = [_inputBgImageView.image stretchableImageWithLeftCapWidth:8 topCapHeight:20];
    
    [self _initPanGesture];
}


- (void) setFillType:(InfoFillType)fillType
{
    _fillType = fillType;
    
    _textField.hidden = (fillType != InfoFillType_TextField);
    if (!_textField.hidden)
    {
        [_textField becomeFirstResponder];
        _inputBgImageView.frameHeight = _textField.boundsHeight;
    }
    
    _textView.hidden = (fillType != InfoFillType_TextView);
    if (!_textView.hidden)
    {
        [_textView becomeFirstResponder];
        _inputBgImageView.frameHeight = _textView.boundsHeight;
    }
    
    _inputLengthView.frameY = _inputBgImageView.frameY + _inputBgImageView.frameHeight - 44.0;
    
    _tableView.hidden = (fillType != InfoFillType_Picker);
    _inputBgImageView.hidden = (fillType == InfoFillType_Picker);
    _inputLengthView.hidden = (fillType == InfoFillType_Picker);
    
    _confirmBtn.hidden = (fillType == InfoFillType_Picker);
}


- (IBAction)cancelBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void) _confirmWithValue:(NSString *)value
{
    [self.view endEditing:YES];
    
    if ([_delegate respondsToSelector:@selector(InfoFillInViewController:fillValue:)])
    {
        [_delegate InfoFillInViewController:self fillValue:value];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)confirmBtnPressed:(id)sender
{
    if ((_fillType == InfoFillType_TextField && [_textField.text length] < 1) ||
        (_fillType == InfoFillType_TextView && [_textView.text length] < 1))
    {
        MBProgressHUD* progressHUD = [[TipViewManager defaultManager] showTipText:@"请填写信息"
                                                                        imageName:kCommonImage_FailIcon
                                                                           inView:self.view
                                                                               ID:self];
        progressHUD.frameY -= 50.0;
        
        [[TipViewManager defaultManager] hideTipWithID:self animation:YES delay:1.25];
        return;
    }
    
    NSString* text = (_fillType == InfoFillType_TextField) ? _textField.text : _textView.text;
    [self _confirmWithValue:text];
}


- (void) textValue:(NSString *)text
{
    _inputLengthLabel.text = [NSString stringWithInt:_textMaxLength - text.length];
    
    _textField.text = text;
    _textView.text = text;
}


- (IBAction)clearText:(id)sender
{
    _inputLengthLabel.text = [NSString stringWithInt:_textMaxLength];
    
    _textField.text = @"";
    _textView.text = @"";
}


#pragma mark- 取消手势
- (void) _initPanGesture
{
    [self.view removeGestureRecognizer:_panGesture];
    _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                          action:@selector(_handlePan:)];
    [self.view addGestureRecognizer:_panGesture];
}


- (void) _handlePan:(UIPanGestureRecognizer *)panGesture
{
    if (panGesture.state == UIGestureRecognizerStateEnded)
    {
        CGPoint offset = [panGesture translationInView:self.view];
        
        if (offset.x > kPanWidth)
        {
            [self cancelBtnPressed:nil];
        }
    }
}


#pragma mark- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self _confirmWithValue:[_dataList objectAtIndex:indexPath.row]];
}


#pragma mark- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"InfoFillCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    
    NSString* showMsg = [_dataList objectAtIndex:indexPath.row];
    cell.textLabel.text = showMsg;
    cell.textLabel.font = [UIFont fontWithName:@"ArialMT" size:16.0];
    cell.textLabel.textColor = GMETColorRGBMake(39, 39, 39);
    return cell;
}


#pragma mark- UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([_delegate respondsToSelector:@selector(InfoFillInViewController:fillValue:)])
    {
        [_delegate InfoFillInViewController:self fillValue:textField.text];
    }
    
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
    
    return YES;
}


- (BOOL)            textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range
            replacementString:(NSString *)string
{
    NSString* result = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if ([result length] > _textMaxLength)
    {
        return NO;
    }
    
    _inputLengthLabel.text = [NSString stringWithInt:_textMaxLength - result.length];
    return YES;
}


#pragma mark- UITextViewDelegate
- (BOOL)        textView:(UITextView *)textView
 shouldChangeTextInRange:(NSRange)range
         replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
    {
        [self _confirmWithValue:textView.text];
        return NO;
    }
    
    NSString* result = [textView.text stringByReplacingCharactersInRange:range withString:text];
    if (result.length > _textMaxLength)
    {
        return NO;
    }
    
    _inputLengthLabel.text = [NSString stringWithInt:_textMaxLength - result.length];
    return YES;
}

@end
