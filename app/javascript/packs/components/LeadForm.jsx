import { CircularProgress, withStyles } from '@material-ui/core';
import Button from '@material-ui/core/Button';
import FormControl from '@material-ui/core/FormControl';
import TextField from '@material-ui/core/TextField';
import React, { Component } from 'react';
import { Form } from 'formik';

class LeadForm extends Component {
  onChange = name => event => {
    const { handleChange, setFieldTouched } = this.props;

    handleChange(event);
    setFieldTouched(name, true, false);
  };

  render() {
    const {
      values: {
        email,
        name,
        business_name,
        telephone_number,
        contact_time,
        notes,
        reference
      },
      isSubmitting,
      errors,
      classes
    } = this.props;

    return (
      <Form>
        <FormControl className={classes.formControl}>
          <TextField
            label="Email"
            placeholder="Enter email here..."
            name="email"
            type="email"
            required
            value={email}
            error={Boolean(errors.email)}
            helperText={errors.email || ''}
            onChange={this.onChange('email')}
            fullWidth
          />
        </FormControl>

        <FormControl className={classes.formControl}>
          <TextField
            label="Name"
            placeholder="Enter name here..."
            name="name"
            required
            value={name}
            error={Boolean(errors.name)}
            helperText={errors.name || ''}
            onChange={this.onChange('name')}
            fullWidth
          />
        </FormControl>

        <FormControl className={classes.formControl}>
          <TextField
            label="Business Name"
            placeholder="Enter business name here..."
            name="business_name"
            required
            value={business_name}
            error={Boolean(errors.business_name)}
            helperText={errors.business_name || ''}
            onChange={this.onChange('business_name')}
            fullWidth
          />
        </FormControl>

        <FormControl className={classes.formControl}>
          <TextField
            label="Phone number"
            placeholder="Enter phone number here..."
            name="telephone_number"
            required
            value={telephone_number}
            error={Boolean(errors.telephone_number)}
            helperText={errors.telephone_number || ''}
            onChange={this.onChange('telephone_number')}
            fullWidth
          />
        </FormControl>

        <FormControl className={classes.formControl}>
          <TextField
            label="Contact time"
            placeholder="Enter contact time here..."
            name="contact_time"
            value={contact_time}
            error={Boolean(errors.contact_time)}
            helperText={errors.contact_time || ''}
            onChange={this.onChange('contact_time')}
            fullWidth
          />
        </FormControl>

        <FormControl className={classes.formControl}>
          <TextField
            label="Notes"
            placeholder="Enter notes here..."
            name="notes"
            value={notes}
            error={Boolean(errors.notes)}
            helperText={errors.notes || ''}
            onChange={this.onChange('notes')}
            multiline
            fullWidth
          />
        </FormControl>

        <FormControl className={classes.formControl}>
          <TextField
            label="Reference"
            placeholder="Enter reference here..."
            name="reference"
            value={reference}
            error={Boolean(errors.reference)}
            helperText={errors.reference || ''}
            onChange={this.onChange('reference')}
            fullWidth
          />
        </FormControl>

        <FormControl className={classes.actions}>
          <Button
            type="submit"
            disabled={isSubmitting}
            color="primary"
            variant="contained"
          >
            {
              isSubmitting && <CircularProgress className={classes.progress} color="inherit" size={16} />
            }
            Submit
          </Button>
        </FormControl>
      </Form>
    );
  }
}

export default withStyles(
  theme => ({
    formControl: {
      display: 'block',
      marginBottom: theme.spacing(3)
    },
    actions: {
      display: 'flex',
      justifyContent: 'flex-end',
      flexDirection: 'row',
      marginTop: theme.spacing(4)
    },
    progress: {
      marginRight: theme.spacing(2)
    }
  })
)(LeadForm);
